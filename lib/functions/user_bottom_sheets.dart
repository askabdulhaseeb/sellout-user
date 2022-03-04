import 'package:flutter/material.dart';
import '../database/chat_api.dart';
import '../models/app_user.dart';
import '../screens/message_screens/personal/personal_chat_screen.dart';
import '../widgets/custom_widgets/custom_profile_image.dart';

class UserBottomSheets {
  PersistentBottomSheetController<dynamic> showNewChatPersons({
    required BuildContext context,
    required List<AppUser> users,
  }) {
    return showBottomSheet(
      context: context,
      enableDrag: true,
      builder: (BuildContext context) => Column(
        children: <Widget>[
          const SizedBox(height: 30),
          Row(
            children: <Widget>[
              IconButton(
                splashRadius: 20,
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(Icons.adaptive.arrow_back_rounded),
              ),
              const Text(
                'New Chat',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: users.length,
              itemBuilder: (BuildContext context, int index) => ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute<PersonalChatScreen>(
                      builder: (_) => PersonalChatScreen(
                        otherUser: users[index],
                        chatID: ChatAPI.getChatID(
                          othersUID: users[index].uid,
                        ),
                      ),
                    ),
                  );
                },
                leading: CustomProfileImage(
                  imageURL: users[index].imageURL ?? '',
                ),
                title: Text(
                  users[index].displayName ?? 'Name fetching issue',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  users[index].bio ?? 'Bio fetching issue',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
