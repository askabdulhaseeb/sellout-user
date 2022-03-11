import 'package:cloud_firestore/cloud_firestore.dart';
import '../enums/privacy_type.dart';
import 'bet.dart';

class Auction {
  Auction({
    required this.id,
    required this.name,
    required this.decription,
    required this.startingPrice,
    required this.bets,
    required this.timestamp,
    required this.privacy,
  });

  final String id;
  final String name;
  final String decription;
  final double startingPrice;
  final List<Bet> bets;
  final int timestamp;
  final ProdPrivacyTypeEnum privacy;

  Map<String, dynamic> toMap() {
    List<Map<String, dynamic>> _mapp = <Map<String, dynamic>>[];
    for (Bet element in bets) {
      _mapp.add(element.toMap());
    }
    return <String, dynamic>{
      'id': id,
      'name': name,
      'decription': decription,
      'startingPrice': startingPrice,
      'bets': _mapp,
      'timestamp': timestamp,
      'privacy': ProdPrivacyTypeEnumConvertor.enumToString(privacy: privacy),
    };
  }

  // ignore: sort_constructors_first
  factory Auction.fromMap(DocumentSnapshot<Map<String, dynamic>> doc) {
    final List<Bet> _temp = <Bet>[];
    final List<dynamic> _list = doc.data()?['bets'];
    _list.forEach(((dynamic element) => _temp.add(Bet.fromMap(element))));
    return Auction(
      id: doc.data()?['id'] ?? '',
      name: doc.data()?['name'] ?? '',
      decription: doc.data()?['decription'] ?? '',
      startingPrice: double.parse(doc.data()?['startingPrice'] ?? '0.0'),
      bets: _temp,
      timestamp: int.parse(doc.data()?['timestamp'] ?? '0'),
      privacy: ProdPrivacyTypeEnumConvertor.stringToEnum(
        privacy: doc.data()?['privacy'] ?? ProdPrivacyTypeEnum.PUBLIC,
      ),
    );
  }
}
