import 'package:flutter/material.dart';
import '../../../../../database/auth_methods.dart';
import '../../../../../database/chat_api.dart';
import '../../../../../models/chat.dart';
import '../../../../../widgets/custom_widgets/show_loading.dart';
import '../../../../../widgets/messages/chat_dashboard_tile.dart';

class PersonalChatDashboard extends StatelessWidget {
  const PersonalChatDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Chat>>(
      stream: ChatAPI().fetchChats(AuthMethods.uid).asStream(),
      builder: (_, AsyncSnapshot<List<Chat>> snapshot) {
        if (snapshot.hasError) {
          return const _ErrorWidget();
        } else {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const ShowLoading();
          } else {
            if (snapshot.hasData) {
              final List<Chat> chat = snapshot.data!;
              return ListView.builder(
                itemCount: chat.length,
                itemBuilder: (_, int index) =>
                    ChatDashboardTile(chat: chat[index]),
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
