import 'package:cloud_firestore/cloud_firestore.dart';
import 'message.dart';

class Chat {
  Chat({
    required this.chatID,
    required this.persons,
    required this.lastMessage,
    required this.timestamp,
    this.messages,
    this.pid,
    this.prodIsVideo = false,
  });

  final String chatID;
  final List<String> persons;
  final String lastMessage;
  final int timestamp;
  final List<Message>? messages;
  final String? pid;
  final bool? prodIsVideo;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'chatID': chatID,
      'persons': persons,
      'lastMessage': lastMessage,
      'timestamp': timestamp,
      'pid': pid,
      'prod_is_video': prodIsVideo ?? false,
    };
  }

  // ignore: sort_constructors_first
  factory Chat.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    List<Message> messages = <Message>[];
    return Chat(
      chatID: doc.data()!['chatID'] ?? '',
      persons: List<String>.from(doc.data()!['persons']),
      lastMessage: doc.data()!['lastMessage'] ?? '',
      timestamp: doc.data()!['timestamp'] ?? '',
      pid: doc.data()?['pid'],
      prodIsVideo: doc.data()?['prod_is_video'] ?? true,
      messages: messages,
    );
  }
}
