import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../../../database/auth_methods.dart';
import '../../../../../models/chat.dart';
import '../../../../../widgets/messages/chat_dashboard_tile.dart';
import '../../../../../widgets/messages/product_chat_dashboard_tile.dart';

class PersonalChatDashboard extends StatelessWidget {
  const PersonalChatDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('chats')
          .orderBy('timestamp', descending: true)
          .where('persons', arrayContains: AuthMethods.uid)
          .snapshots(),
      builder:
          (_, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.hasError) {
          return const _ErrorWidget();
        } else {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // return const ShowLoading();
            return const SizedBox();
          } else {
            if (snapshot.hasData) {
              List<Chat> chat = <Chat>[];
              for (QueryDocumentSnapshot<Map<String, dynamic>> doc
                  in snapshot.data!.docs) {
                chat.add(Chat.fromDoc(doc));
              }
              return ListView.separated(
                itemCount: chat.length,
                separatorBuilder: (_, __) => const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Divider(height: 1),
                ),
                itemBuilder: (_, int index) {
                  return chat[index].pid == null
                      ? ChatDashboardTile(chat: chat[index])
                      : ProductChatDashboardTile(chat: chat[index]);
                },
              );
            } else {
              return const Text('Error Text');
            }
          }
        }
      },
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  const _ErrorWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: const <Widget>[
          Text(
            'Some thing goes wrong',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
