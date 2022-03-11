import 'package:cloud_firestore/cloud_firestore.dart';
import '../database/auth_methods.dart';
import '../enums/privacy_type.dart';
import 'bet.dart';

class Auction {
  Auction({
    required this.auctionID,
    required this.uid,
    required this.name,
    required this.decription,
    required this.startingPrice,
    this.bets,
    required this.timestamp,
    required this.privacy,
  });

  final String auctionID;
  final String uid;
  final String name;
  final String decription;
  final double startingPrice;
  final List<Bet>? bets;
  final int timestamp;
  final ProdPrivacyTypeEnum privacy;

  Map<String, dynamic> toMap() {
    List<Map<String, dynamic>> _mapp = <Map<String, dynamic>>[];
    for (Bet element in bets ?? <Bet>[]) {
      _mapp.add(element.toMap());
    }
    return <String, dynamic>{
      'auction_id': auctionID,
      'uid': uid,
      'name': name,
      'decription': decription,
      'startingPrice': startingPrice,
      'bets': _mapp,
      'timestamp': timestamp,
      'privacy': ProdPrivacyTypeEnumConvertor.enumToString(privacy: privacy),
    };
  }

  Map<String, dynamic> updateBets() {
    List<Map<String, dynamic>> _mapp = <Map<String, dynamic>>[];
    for (Bet element in bets ?? <Bet>[]) {
      _mapp.add(element.toMap());
    }
    return <String, dynamic>{
      'bets': _mapp,
    };
  }

  // ignore: sort_constructors_first
  factory Auction.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final List<Bet> _temp = <Bet>[];
    final List<dynamic> _list = doc.data()?['bets'];
    _list.forEach(((dynamic element) => _temp.add(Bet.fromMap(element))));
    return Auction(
      auctionID: doc.data()?['auction_id'] ?? '',
      uid: doc.data()?['uid'] ?? AuthMethods.uid,
      name: doc.data()?['name'] ?? '',
      decription: doc.data()?['decription'] ?? '',
      startingPrice:
          double.parse(doc.data()?['startingPrice'].toString() ?? '0.0'),
      bets: _temp,
      timestamp: int.parse(doc.data()?['timestamp'].toString() ?? '0'),
      privacy: ProdPrivacyTypeEnumConvertor.stringToEnum(
        privacy: doc.data()?['privacy'] ?? ProdPrivacyTypeEnum.PUBLIC,
      ),
    );
  }
}
