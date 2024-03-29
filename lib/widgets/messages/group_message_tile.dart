import 'package:flutter/material.dart';
import '../../database/auth_methods.dart';
import '../../models/app_user.dart';
import '../../models/message.dart';
import '../../screens/others_profile/others_profile.dart';
import '../../utilities/utilities.dart';

class GroupMessageTile extends StatelessWidget {
  const GroupMessageTile({
    required this.message,
    required this.user,
    required this.boxWidth,
    Key? key,
  }) : super(key: key);
  final Message message;
  final AppUser user;
  final double boxWidth;
  @override
  Widget build(BuildContext context) {
    final bool isMe = AuthMethods.uid == message.sendBy;
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        Wrap(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(vertical: 4),
              // : const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                // Message Container Design
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(14),
                  bottomRight: isMe
                      ? const Radius.circular(0)
                      : const Radius.circular(14),
                  topRight: const Radius.circular(14),
                  bottomLeft: isMe
                      ? const Radius.circular(14)
                      : const Radius.circular(0),
                ),
                color: isMe
                    ? Theme.of(context).primaryColor
                    // : const Color(0xfff0f0fA),
                    : Colors.grey.shade300,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  const SizedBox(height: 4),
                  if (!isMe)
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<OthersProfile>(
                            builder: (_) => OthersProfile(user: user),
                          ),
                        );
                      },
                      child: SizedBox(
                        width: boxWidth,
                        child: Text(
                          user.displayName ?? 'name show issue',
                          style: TextStyle(
                            color: (isMe) ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  SizedBox(
                    width: boxWidth,
                    child: Text(
                      message.message,
                      style: TextStyle(
                        color: (isMe) ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        Utilities.timeInDigits(message.timestamp),
                        style: TextStyle(
                          color: (isMe) ? Colors.white70 : Colors.black54,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
