import 'package:cloud_firestore/cloud_firestore.dart';

import '../database/auth_methods.dart';

class Stories {
  Stories({
    required this.sid,
    required this.url,
    required this.timestamp,
    this.views,
    this.isVideo = false,
    this.title = '',
    this.uid,
    this.isExpaired = false,
  });

  final String sid;
  final String url;
  final int timestamp;
  final List<String>? views;
  bool? isVideo;
  String? title;
  String? uid;
  bool? isExpaired;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sid': sid,
      'url': url,
      'timestamp': timestamp,
      'views': views,
      'is_video': isVideo ?? false,
      'title': title ?? '',
      'uid': uid ?? AuthMethods.uid,
      'is_expaired': isExpaired ?? false,
    };
  }

  // ignore: sort_constructors_first
  factory Stories.fromMap(Map<String, dynamic> map) {
    return Stories(
      sid: map['sid'] ?? '',
      url: map['url'] ?? '',
      isVideo: map['is_video'] ?? false,
      views: List<String>.from(map['views']),
      timestamp: map['timestamp'] ?? DateTime.now().microsecondsSinceEpoch,
      title: map['title'] ?? '',
      uid: map['uid'] ?? '',
      isExpaired: map['is_expaired'] ?? false,
    );
  }
  // ignore: sort_constructors_first
  factory Stories.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    return Stories(
      sid: doc.data()?['sid'] ?? '',
      url: doc.data()?['url'] ?? '',
      isVideo: doc.data()?['is_video'] ?? false,
      views: List<String>.from(doc.data()?['views'] ?? <String>[]),
      timestamp:
          doc.data()?['timestamp'] ?? DateTime.now().microsecondsSinceEpoch,
      title: doc.data()?['title'] ?? '',
      uid: doc.data()?['uid'] ?? '',
      isExpaired: doc.data()?['is_expaired'] ?? false,
    );
  }
}
