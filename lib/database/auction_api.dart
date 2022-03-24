import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extended_image/extended_image.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/auction.dart';
import '../widgets/custom_widgets/custom_toast.dart';
import 'auth_methods.dart';

class AuctionAPI {
  static const String _colloction = 'auction';
  static final FirebaseFirestore _instance = FirebaseFirestore.instance;

  Future<bool> startAuction(Auction auction) async {
    try {
      _instance
          .collection(_colloction)
          .doc(auction.auctionID)
          .set(auction.toMap());
      return true;
    } catch (e) {
      CustomToast.errorToast(message: e.toString());
      return false;
    }
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamAuction(
      {required Auction auction}) {
    return _instance.collection(_colloction).doc(auction.auctionID).snapshots();
  }

  Future<List<Auction>> getAllAuctions() async {
    final List<Auction> _auction = <Auction>[];
    final QuerySnapshot<Map<String, dynamic>> doc =
        await _instance.collection(_colloction).get();

    for (DocumentSnapshot<Map<String, dynamic>> element in doc.docs) {
      _auction.add(Auction.fromDoc(element));
    }
    return _auction;
  }

  Future<void> updateBet({required Auction auction}) async {
    await _instance
        .collection(_colloction)
        .doc(auction.auctionID)
        .update(auction.updateBets());
  }

  Future<String?> uploadImage({required String id, required File file}) async {
    try {
      TaskSnapshot snapshot = await FirebaseStorage.instance
          .ref('auctions/${AuthMethods.uid}/$id')
          .putFile(file);
      String url = await snapshot.ref.getDownloadURL();
      return url;
    } catch (e) {
      return null;
    }
  }
}
