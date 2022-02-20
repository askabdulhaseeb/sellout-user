import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../../../database/auth_methods.dart';
import '../../../../../database/chat_api.dart';
import '../../../../../models/app_user.dart';
import '../../../../../models/chat.dart';
import '../../../../../models/message.dart';
import '../../../../../services/user_local_data.dart';
import '../../../../../utilities/utilities.dart';
import '../../../../../widgets/custom_widgets/custom_profile_image.dart';
import '../../../../../widgets/messages/chat_textformfield.dart';
import '../../../../../widgets/messages/personal_message_tile.dart';
import '../../others_profile/others_profile.dart';

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
                                              : widget.otherUser.displayName!,
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
      title: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute<OthersProfile>(
              builder: (_) => OthersProfile(user: otherUser),
            ),
          );
        },
        child: Row(
          children: <Widget>[
            CustomProfileImage(imageURL: widget.otherUser.imageURL ?? ''),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.otherUser.displayName ?? 'issue',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const Text(
                    'Tap here to open profile',
                    style: TextStyle(fontSize: 11, color: Colors.grey),
                  )
                ],
              ),
            ),
          ],
        ),
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
