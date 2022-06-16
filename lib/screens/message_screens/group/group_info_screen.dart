import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../models/group_chat.dart';
import '../../../enums/messages/role_in_chat_group.dart';
import '../../../models/app_user.dart';
import '../../../models/group_chat_participant.dart';
import '../../../providers/user_provider.dart';
import '../../../widgets/custom_widgets/custom_profile_image.dart';
import '../../others_profile/others_profile.dart';

class GroupInfoScreen extends StatelessWidget {
  const GroupInfoScreen({required this.group, Key? key}) : super(key: key);
  final GroupChat group;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(group.name ?? '-'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 15 / 8,
                  child: group.imageURL == null || group.imageURL == ''
                      ? Container(
                          color: Colors.grey,
                          child: const FittedBox(
                            child: Icon(Icons.group),
                          ),
                        )
                      : ExtendedImage.network(group.imageURL ?? ''),
                ),
                Positioned(
                  bottom: 10,
                  right: 16,
                  child: InkWell(
                    onTap: () {},
                    child: const CircleAvatar(
                      backgroundColor: Colors.black12,
                      child: Icon(Icons.photo_camera),
                    ),
                  ),
                ),
              ],
            ),
            _TabableTextBox(
              title: group.name ?? '-',
              onTap: () {},
            ),
            _TabableTextBox(
              title: group.description ?? '-',
              onTap: () {},
              placeholder: 'Add a decription here',
            ),
            Row(
              children: <Widget>[
                const SizedBox(width: 16),
                Text(
                  group.participants?.length.toString() ?? '',
                  style: const TextStyle(color: Colors.grey),
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                  label: const Text('Add Particitant'),
                ),
              ],
            ),
            Consumer<UserProvider>(
              builder: (_, UserProvider provider, __) => ConstrainedBox(
                constraints: const BoxConstraints.tightFor(height: 300),
                child: ListView.builder(
                  itemCount: group.participantsDetail?.length ?? 0,
                  itemBuilder: (_, int index) {
                    final GroupChatParticipant perticipant =
                        group.participantsDetail![index];
                    final AppUser user = provider.user(uid: perticipant.uid);
                    return ListTile(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<OthersProfile>(
                            builder: (_) => OthersProfile(user: user),
                          ),
                        );
                      },
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16),
                      leading:
                          CustomProfileImage(imageURL: user.imageURL ?? ''),
                      title: Text(user.displayName ?? 'issue in name'),
                      trailing: Text(
                        GroupParticipantRoleTypeConverter.formEnum(
                                perticipant.role)
                            .toLowerCase(),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TabableTextBox extends StatelessWidget {
  const _TabableTextBox({
    required this.title,
    required this.onTap,
    this.placeholder,
    Key? key,
  }) : super(key: key);
  final String title;
  final VoidCallback onTap;
  final String? placeholder;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: (title.isEmpty)
          ? Text(
              placeholder ?? '',
              style: const TextStyle(color: Colors.grey),
            )
          : Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
    );
  }
}
