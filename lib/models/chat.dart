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
  });

  final String chatID;
  final List<String> persons;
  final String lastMessage;
  final int timestamp;
  final List<Message>? messages;
  final String? pid;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'chatID': chatID,
      'persons': persons,
      'lastMessage': lastMessage,
      'timestamp': timestamp,
      'pid': pid,
    };
  }

  // ignore: sort_constructors_first
  factory Chat.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    List<Message> _messages = <Message>[];
    // doc.data()!['messages'].forEach((dynamic e) {
    //   _messages.add(Messages.fromDoc(e));
    // });
    return Chat(
      chatID: doc.data()!['chatID'] ?? '',
      persons: List<String>.from(doc.data()!['persons']),
      lastMessage: doc.data()!['lastMessage'] ?? '',
      timestamp: doc.data()!['timestamp'] ?? '',
      pid: doc.data()?['pid'],
      messages: _messages,
    );
  }
}
