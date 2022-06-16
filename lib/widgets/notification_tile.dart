import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/app_user.dart';
import '../models/my_notification.dart';
import '../providers/user_provider.dart';
import 'custom_widgets/custom_profile_image.dart';

class NotificationTile extends StatelessWidget {
  const NotificationTile({required this.notification, this.trailing, Key? key})
      : super(key: key);
  final MyNotification notification;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (BuildContext context, UserProvider userPro, _) {
        final AppUser sender = userPro.user(uid: notification.by);
        return ListTile(
          onTap: () {},
          dense: true,
          leading: CustomProfileImage(imageURL: sender.imageURL ?? ''),
          title: Text(
            sender.displayName ?? 'name not found',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            notification.subtitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: trailing,
        );
      },
    );
  }
}
