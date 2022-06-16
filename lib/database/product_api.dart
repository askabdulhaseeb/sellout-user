import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/product.dart';
import '../services/user_local_data.dart';
import 'user_api.dart';

class ProductAPI {
  static const String _collection = 'products';
  static final FirebaseFirestore _instance = FirebaseFirestore.instance;

  // functions
  Future<Product?>? getProductByPID({required String pid}) async {
    final DocumentSnapshot<Map<String, dynamic>> doc =
        await _instance.collection(_collection).doc(pid).get();
    if (doc.data() == null) return null;
    return Product.fromDoc(doc);
  }

  Future<List<Product>> getProductsByUID({required String uid}) async {
    List<Product> products = <Product>[];
    final QuerySnapshot<Map<String, dynamic>> doc = await _instance
        .collection(_collection)
        .where('uid', isEqualTo: uid)
        .orderBy('timestamp', descending: true)
        .get();
    for (DocumentSnapshot<Map<String, dynamic>> element in doc.docs) {
      products.add(Product.fromDoc(element));
    }
    return products;
  }

  Future<List<Product>> getProducts() async {
    List<Product> products = <Product>[];
    final QuerySnapshot<Map<String, dynamic>> doc = await _instance
        .collection(_collection)
        .orderBy('timestamp', descending: true)
        .get();
    for (DocumentSnapshot<Map<String, dynamic>> element in doc.docs) {
      products.add(Product.fromDoc(element));
    }
    return products;
  }

  Future<bool> addProduct(Product product) async {
    try {
      // ignore: always_specify_types
      Future.wait([
        _instance.collection(_collection).doc(product.pid).set(product.toMap()),
        UserAPI().updatePosts(product.pid),
      ]);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String?> uploadImage({required String pid, required File file}) async {
    try {
      TaskSnapshot snapshot = await FirebaseStorage.instance
          .ref(
              'products/${UserLocalData.getUID}/$pid/${DateTime.now().microsecondsSinceEpoch}')
          .putFile(file);
      String url = await snapshot.ref.getDownloadURL();
      return url;
    } catch (e) {
      return null;
    }
  }
}
