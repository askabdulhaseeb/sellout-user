import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product.dart';
import '../widgets/custom_toast.dart';

class ProductAPI {
  static const String _collection = 'products';
  static final FirebaseFirestore _instance = FirebaseFirestore.instance;

  // functions
  Future<Product?>? getProductByPID({required String pid}) async {
    final DocumentSnapshot<Map<String, dynamic>>? doc =
        await _instance.collection(_collection).doc(pid).get();
    if (doc?.data() == null) return null;
    return Product.fromDoc(doc!);
  }

  Future<bool> addProduct(Product product) async {
    await _instance
        .collection(_collection)
        .doc(product.pid)
        .set(product.toMap())
        .catchError((Object e) {
      CustomToast.errorToast(message: e.toString());
      // ignore: invalid_return_type_for_catch_error
      return false;
    });
    return true;
  }
}
