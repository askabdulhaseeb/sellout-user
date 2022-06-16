import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/custom_widgets/custom_toast.dart';
import '../models/chat.dart';
import '../models/message.dart';
import 'auth_methods.dart';

class ChatAPI {
  static const String _colloction = 'chats';
  static const String _subColloction = 'messages';
  static final FirebaseFirestore _instance = FirebaseFirestore.instance;
  // functions
  static String getChatID({required String othersUID}) {
    int isGreaterThen = AuthMethods.uid.compareTo(othersUID);
    if (isGreaterThen > 0) {
      return '${AuthMethods.uid}-chats-$othersUID';
    } else {
      return '$othersUID-chats-${AuthMethods.uid}';
    }
  }
  // functions
  static String getProductChatID({required String pid}) {
      return '${AuthMethods.uid}-product-$pid';
  }

  Future<void> sendMessage(Chat chat, Message messages) async {
    // ignore: always_specify_types
    try {
      // ignore: always_specify_types
      Future.wait([
        _instance
            .collection(_colloction)
            .doc(chat.chatID)
            .collection(_subColloction)
            .doc(messages.messageID)
            .set(messages.toMap()),
        _instance.collection(_colloction).doc(chat.chatID).set(chat.toMap()),
      ]);
    } catch (e) {
      CustomToast.errorToast(message: e.toString());
    }
  }

  Future<Chat?> fetchChat(String chatID) async {
    final DocumentSnapshot<Map<String, dynamic>> doc =
        await _instance.collection(_colloction).doc(chatID).get();
    if (!doc.exists) return null;
    Chat chat = Chat.fromDoc(doc);
    return chat;
  }

  Future<List<Chat>> fetchChats(String uid) async {
    List<Chat> chat = <Chat>[];
    try {
      final Stream<QuerySnapshot<Map<String, dynamic>>> docs = _instance
          .collection(_colloction)
          .orderBy('timestamp', descending: true)
          .where('persons', arrayContains: uid)
          .snapshots();
      docs.forEach((QuerySnapshot<Map<String, dynamic>> snap) {
        for (DocumentSnapshot<Map<String, dynamic>> element in snap.docs) {
          chat.add(Chat.fromDoc(element));
        }
      });
    } catch (e) {
      CustomToast.errorToast(message: e.toString());
    }
    return chat;
  }

  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> fetchMessages(
      String chatID) async {
    return _instance
        .collection(_colloction)
        .doc(chatID)
        .collection(_subColloction)
        .orderBy('timestamp', descending: true)
        .snapshots();
    // List<Messages> _messages = <Messages>[];
    // // print(docs.docs);
    // for (DocumentSnapshot<Map<String, dynamic>> doc in docs.docs) {
    //   _messages.add(Messages.fromDoc(doc));
    // }
    // return _messages;
  }
}
