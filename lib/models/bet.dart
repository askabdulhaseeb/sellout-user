class Bet {
  Bet({
    required this.uid,
    required this.amount,
    required this.timestamp,
    this.isSold = false,
  });

  final String uid;
  final double amount;
  final bool isSold;
  final int timestamp;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'amount': amount,
      'isSold': isSold,
      'timestamp': timestamp,
    };
  }

  // ignore: sort_constructors_first
  factory Bet.fromMap(Map<String, dynamic> map) {
    return Bet(
      uid: map['uid'] ?? '',
      amount: double.parse(map['amount'].toString()),
      isSold: map['isSold'] ?? false,
      timestamp: int.parse(map['timestamp'].toString()),
    );
  }
}
