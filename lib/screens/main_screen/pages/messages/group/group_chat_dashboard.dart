import 'package:flutter/material.dart';
import 'package:sellout/utilities/utilities.dart';
import '../../../../../database/group_chat_api.dart';
import '../../../../../models/group_chat.dart';
import '../../../../../widgets/custom_widgets/show_loading.dart';

class GroupChatDashboaed extends StatelessWidget {
  const GroupChatDashboaed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<GroupChat>>(
      stream: GroupChatAPI().getGroups().asStream(),
      builder: (_, AsyncSnapshot<List<GroupChat>> snapshot) {
        if (snapshot.hasError) {
          return const _ErrorWidget();
        } else {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const ShowLoading();
          } else {
            if (snapshot.hasData) {
              final List<GroupChat> _group = snapshot.data!;
              return ListView.builder(
                itemCount: _group.length,
                itemBuilder: (_, int index) =>
                    GroupChatDashboardTile(group: _group[index]),
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
      onTap: () {},
      dense: false,
      title: Text(group.name ?? 'Issue'),
      subtitle: Text(group.lastMessage ?? ''),
      trailing: Text(
        Utilities.timeInDigits(group.timestamp!),
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
