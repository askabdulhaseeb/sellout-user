import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/auction.dart';
import '../widgets/custom_widgets/custom_toast.dart';

class AuctionAPI {
  static const String _colloction = 'auction';
  static final FirebaseFirestore _instance = FirebaseFirestore.instance;

  Future<bool> startAuction(Auction auction) async {
    try {
      _instance.collection(_colloction).doc(auction.id).set(auction.toMap());
      return true;
    } catch (e) {
      CustomToast.errorToast(message: e.toString());
      return false;
    }
  }
}
