import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../../../database/auth_methods.dart';
import '../../../../../models/group_chat.dart';
import '../../../../../utilities/utilities.dart';
import '../../../../../widgets/custom_widgets/custom_profile_image.dart';
import '../../../../../widgets/custom_widgets/show_loading.dart';
import 'group_chat_screen.dart';

class GroupChatDashboaed extends StatelessWidget {
  const GroupChatDashboaed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('chat_groups')
          .orderBy('timestamp', descending: true)
          .where('participants', arrayContains: AuthMethods.uid)
          .snapshots(),
      builder:
          (_, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.hasError) {
          return const _ErrorWidget();
        } else {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const ShowLoading();
          } else {
            if (snapshot.hasData) {
              final List<GroupChat> group = <GroupChat>[];
              for (QueryDocumentSnapshot<Map<String, dynamic>> doc
                  in snapshot.data!.docs) {
                group.add(GroupChat.fromDoc(doc));
              }
              return group.isEmpty
                  ? const Center(
                      child: Text('You are not a part of any group'),
                    )
                  : ListView.separated(
                      itemCount: group.length,
                      separatorBuilder: (_, __) => const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Divider(height: 1),
                      ),
                      itemBuilder: (_, int index) =>
                          GroupChatDashboardTile(group: group[index]),
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

class GroupChatDashboardTile extends StatelessWidget {
  const GroupChatDashboardTile({
    required this.group,
    Key? key,
  }) : super(key: key);

  final GroupChat group;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute<GroupChatScreen>(
            builder: (_) => GroupChatScreen(group: group),
          ),
        );
      },
      dense: true,
      leading: CustomProfileImage(imageURL: group.imageURL ?? ''),
      title: Text(
        group.name ?? 'Issue',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(group.lastMessage ?? ''),
      trailing: Text(
        Utilities.timeInDigits(group.timestamp!),
        style: const TextStyle(fontSize: 12),
      ),
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
