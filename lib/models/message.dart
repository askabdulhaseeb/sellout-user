import 'package:cloud_firestore/cloud_firestore.dart';
import '../database/auth_methods.dart';
import '../enums/messages/message_type_enum.dart';

class Message {
  Message({
    required this.messageID,
    required this.message,
    required this.timestamp,
    this.sendBy,
    this.type = MessageTypeEnum.TEXT,
  });

  final String messageID;
  final String message;
  final int timestamp;
  final String? sendBy;
  final MessageTypeEnum? type;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message_id': messageID,
      'message': message,
      'timestamp': timestamp,
      'send_by': sendBy ?? AuthMethods.uid,
      'type': MessageTypeConverter.enumToString(
        type: type ?? MessageTypeEnum.TEXT,
      ),
    };
  }

  // ignore: sort_constructors_first
  factory Message.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    return Message(
      messageID: doc.data()?['message_id'] ?? '',
      message: doc.data()?['message'] ?? '',
      timestamp: doc.data()?['timestamp'] ?? 0,
      sendBy: doc.data()?['send_by'] ?? '',
      type: MessageTypeConverter.stringToEnum(
        type: doc.data()?['type'] ?? 'TEXT',
      ),
    );
  }
}
