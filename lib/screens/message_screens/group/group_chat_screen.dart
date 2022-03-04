import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../database/auth_methods.dart';
import '../../../../../database/group_chat_api.dart';
import '../../../../../enums/messages/message_type_enum.dart';
import '../../../../../models/group_chat.dart';
import '../../../../../models/message.dart';
import '../../../../../utilities/utilities.dart';
import '../../../../../widgets/custom_widgets/custom_profile_image.dart';
import '../../../../../widgets/messages/chat_textformfield.dart';
import '../../../providers/user_provider.dart';
import '../../../widgets/messages/group_message_tile.dart';
import 'group_info_screen.dart';

class GroupChatScreen extends StatefulWidget {
  const GroupChatScreen({required this.group, Key? key}) : super(key: key);
  final GroupChat group;
  @override
  State<GroupChatScreen> createState() => _GroupChatScreenState();
}

class _GroupChatScreenState extends State<GroupChatScreen> {
  final TextEditingController _text = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _appBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Utilities.padding),
        child: Column(
          children: <Widget>[
            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection('chat_groups')
                    .doc(widget.group.groupID)
                    .collection('messages')
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (_,
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
                            : Consumer<UserProvider>(
                                builder: (_, UserProvider provider, __) =>
                                    ListView.builder(
                                  shrinkWrap: true,
                                  reverse: true,
                                  itemCount: _messages.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return GroupMessageTile(
                                      boxWidth: _size.width * 0.65,
                                      message: _messages[index],
                                      user: provider.user(
                                        uid: _messages[index].sendBy ??
                                            AuthMethods.uid,
                                      ),
                                    );
                                  },
                                ),
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
                },
              ),
            ),
            ChatTestFormField(
                controller: _text,
                onSendPressed: () async {
                  int _time = DateTime.now().microsecondsSinceEpoch;
                  widget.group.lastMessage = _text.text;
                  widget.group.timestamp = _time;
                  widget.group.type = MessageTypeEnum.TEXT;
                  await GroupChatAPI().sendMessage(
                    group: widget.group,
                    messages: Message(
                      messageID: _time.toString(),
                      message: _text.text.trim(),
                      timestamp: _time,
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

  AppBar _appBar() {
    return AppBar(
      titleSpacing: 0,
      title: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute<GroupInfoScreen>(
            builder: (_) => GroupInfoScreen(group: widget.group),
          ));
        },
        child: Row(
          children: <Widget>[
            CustomProfileImage(imageURL: widget.group.imageURL ?? ''),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.group.name ?? 'issue',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const Text(
                    'Tab here for group info',
                    style: TextStyle(fontSize: 11, color: Colors.grey),
                  ),
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
