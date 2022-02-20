import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/app_user.dart';
import '../../models/stories.dart';
import '../../providers/app_provider.dart';
import '../../utilities/utilities.dart';
import '../custom_widgets/custom_profile_image.dart';

class StoryTile extends StatelessWidget {
  const StoryTile({required this.stories, Key? key}) : super(key: key);
  final List<Stories> stories;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      contentPadding: const EdgeInsets.all(0),
      horizontalTitleGap: 10,
      leading: Container(
        padding: const EdgeInsets.all(1.5),
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).primaryColor,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: CustomProfileImage(imageURL: stories[0].url),
      ),
      title: Text(
        Provider.of<AppProvider>(context)
                .user(uid: stories[0].uid ?? '')
                .displayName ??
            'Name fetching issue',
      ),
      subtitle: Text(
        Utilities.timeInWords(
          DateTime.now().microsecondsSinceEpoch,
        ),
      ),
      trailing: IconButton(
        splashRadius: 20,
        onPressed: () {},
        icon: const Icon(Icons.more_vert_outlined),
      ),
    );
  }
}
