import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sellout/database/auth_methods.dart';
import 'package:sellout/database/chat_api.dart';
import 'package:sellout/models/app_user.dart';
import 'package:sellout/models/chat.dart';
import 'package:sellout/models/message.dart';
import 'package:sellout/services/user_local_data.dart';
import 'package:sellout/utilities/utilities.dart';
import 'package:sellout/widgets/custom_widgets/custom_profile_image.dart';
import 'package:sellout/widgets/messages/chat_textformfield.dart';
import 'package:sellout/widgets/messages/personal_message_tile.dart';

class PersonalChatScreen extends StatefulWidget {
  const PersonalChatScreen(
      {required this.otherUser, required this.chatID, Key? key})
      : super(key: key);
  final AppUser otherUser;
  final String chatID;
  @override
  _PersonalChatScreenState createState() => _PersonalChatScreenState();
}

class _PersonalChatScreenState extends State<PersonalChatScreen> {
  final TextEditingController _text = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _appBar(otherUser: widget.otherUser),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Utilities.padding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection('chats')
                      .doc(widget.chatID)
                      .collection('messages')
                      .orderBy('timestamp', descending: true)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return const Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      default:
                        if (snapshot.hasData) {
                          List<Message> _messages = <Message>[];
                          for (QueryDocumentSnapshot<Map<String, dynamic>> doc
                              in snapshot.data!.docs) {
                            _messages.add(Message.fromDoc(doc));
                          }
                          return (_messages.isEmpty)
                              ? SizedBox(
                                  width: double.infinity,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const <Widget>[
                                      Text(
                                        'Say Hi!',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'and start conversation',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  reverse: true,
                                  itemCount: _messages.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Material(
                                      child: SizedBox(
                                        child: PersonalMessageTile(
                                          boxWidth: _size.width * 0.65,
                                          message: _messages[index],
                                          displayName: (_messages[index]
                                                      .sendBy ==
                                                  AuthMethods.uid)
                                              ? UserLocalData.getDisplayName
                                              : widget.otherUser.displayName,
                                        ),
                                      ),
                                    );
                                  },
                                );
                        } else {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: const <Widget>[
                              Icon(Icons.report, color: Colors.grey),
                              Text(
                                'Some issue found',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          );
                        }
                    }
                  }),
            ),
            ChatTestFormField(
                controller: _text,
                onSendPressed: () async {
                  int _time = DateTime.now().microsecondsSinceEpoch;
                  await ChatAPI().sendMessage(
                    Chat(
                      chatID: widget.chatID,
                      persons: <String>[AuthMethods.uid, widget.otherUser.uid],
                      lastMessage: _text.text.trim(),
                      timestamp: _time,
                    ),
                    Message(
                      messageID: _time.toString(),
                      message: _text.text.trim(),
                      timestamp: _time,
                      sendBy: AuthMethods.uid,
                    ),
                  );
                  _text.clear();
                }),
            SizedBox(height: Utilities.padding),
          ],
        ),
      ),
    );
  }

  AppBar _appBar({required AppUser otherUser}) {
    return AppBar(
      titleSpacing: 0,
      title: Row(
        children: <Widget>[
          CustomProfileImage(imageURL: widget.otherUser.imageURL ?? ''),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              widget.otherUser.displayName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ],
      ),
      actions: <Widget>[
        IconButton(
          splashRadius: 16,
          padding: const EdgeInsets.all(0),
          icon: const Icon(Icons.video_call),
          onPressed: () {},
        ),
        IconButton(
          splashRadius: 16,
          padding: const EdgeInsets.all(0),
          icon: const Icon(Icons.call),
          onPressed: () {},
        ),
      ],
    );
  }
}

//
// Comp
//
