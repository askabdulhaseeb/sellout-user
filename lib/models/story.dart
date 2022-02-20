import 'package:cloud_firestore/cloud_firestore.dart';

import '../database/auth_methods.dart';
import '../enums/messages/story_media_type_enum.dart';

class Story {
  Story({
    required this.sid,
    required this.url,
    required this.timestamp,
    this.views,
    this.type,
    this.caption = '',
    this.uid,
    this.isExpaired = false,
  });

  final String sid;
  final String url;
  final int timestamp;
  final List<String>? views;
  StoryMediaTypeEnum? type;
  String? caption;
  String? uid;
  bool? isExpaired;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sid': sid,
      'url': url,
      'timestamp': timestamp,
      'views': views ?? <String>[],
      'type': StoryMediaTypeConverter.formEnum(type ?? StoryMediaTypeEnum.TEXT),
      'caption': caption ?? '',
      'uid': uid ?? AuthMethods.uid,
      'is_expaired': isExpaired ?? false,
    };
  }

  // ignore: sort_constructors_first
  factory Story.fromMap(Map<String, dynamic> map) {
    return Story(
      sid: map['sid'] ?? '',
      url: map['url'] ?? '',
      type: StoryMediaTypeConverter.fromString(
          map['type'] ?? StoryMediaTypeEnum.TEXT),
      views: List<String>.from(map['views']),
      timestamp: map['timestamp'] ?? DateTime.now().microsecondsSinceEpoch,
      caption: map['caption'] ?? '',
      uid: map['uid'] ?? '',
      isExpaired: map['is_expaired'] ?? false,
    );
  }
  // ignore: sort_constructors_first
  factory Story.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    return Story(
      sid: doc.data()?['sid'] ?? '',
      url: doc.data()?['url'] ?? '',
      type: StoryMediaTypeConverter.fromString(
          doc.data()?['type'] ?? StoryMediaTypeEnum.TEXT),
      views: List<String>.from(doc.data()?['views'] ?? <String>[]),
      timestamp:
          doc.data()?['timestamp'] ?? DateTime.now().microsecondsSinceEpoch,
      caption: doc.data()?['caption'] ?? '',
      uid: doc.data()?['uid'] ?? '',
      isExpaired: doc.data()?['is_expaired'] ?? false,
    );
  }
}
