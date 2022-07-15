import 'package:cloud_firestore/cloud_firestore.dart';
import '../database/auth_methods.dart';
import '../enums/privacy_type.dart';
import 'bet.dart';

class Auction {
  Auction({
    required this.auctionID,
    required this.uid,
    required this.name,
    required this.thumbnail,
    required this.decription,
    required this.startingPrice,
    required this.timestamp,
    required this.isActive,
    required this.privacy,
    this.bets,
  });

  final String auctionID;
  final String uid;
  final String name;
  final String thumbnail;
  final String decription;
  final double startingPrice;
  final List<Bet>? bets;
  bool isActive;
  final int timestamp;
  final ProdPrivacyTypeEnum privacy;

  Map<String, dynamic> toMap() {
    List<Map<String, dynamic>> mapp = <Map<String, dynamic>>[];
    for (Bet element in bets ?? <Bet>[]) {
      mapp.add(element.toMap());
    }
    return <String, dynamic>{
      'auction_id': auctionID,
      'uid': uid,
      'name': name,
      'thumbnail': thumbnail,
      'decription': decription,
      'startingPrice': startingPrice,
      'bets': mapp,
      'is_active': isActive,
      'timestamp': timestamp,
      'privacy': ProdPrivacyTypeEnumConvertor.enumToString(privacy: privacy),
    };
  }

  Map<String, dynamic> updateActivity() {
    return {
      'is_active': isActive,
    };
  }

  Map<String, dynamic> updateBets() {
    List<Map<String, dynamic>> mapp = <Map<String, dynamic>>[];
    for (Bet element in bets ?? <Bet>[]) {
      mapp.add(element.toMap());
    }
    return <String, dynamic>{
      'bets': mapp,
    };
  }

  // ignore: sort_constructors_first
  factory Auction.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final List<Bet> temp = <Bet>[];
    final List<dynamic> list = doc.data()?['bets'];
    list.forEach(((dynamic element) => temp.add(Bet.fromMap(element))));
    return Auction(
      auctionID: doc.data()?['auction_id'] ?? '',
      uid: doc.data()?['uid'] ?? AuthMethods.uid,
      name: doc.data()?['name'] ?? '',
      thumbnail: doc.data()?['thumbnail'] ?? '',
      decription: doc.data()?['decription'] ?? '',
      startingPrice:
          double.parse(doc.data()?['startingPrice'].toString() ?? '0.0'),
      bets: temp,
      isActive: doc.data()?['is_active'] ?? false,
      timestamp: int.parse(doc.data()?['timestamp'].toString() ?? '0'),
      privacy: ProdPrivacyTypeEnumConvertor.stringToEnum(
        privacy: doc.data()?['privacy'] ?? ProdPrivacyTypeEnum.PUBLIC,
      ),
    );
  }
}
