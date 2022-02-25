import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/app_user.dart';
import '../../models/story.dart';
import '../../providers/user_provider.dart';
import '../../screens/message_screens/stories/stories_view_screen.dart';
import '../../utilities/utilities.dart';
import '../custom_widgets/custom_profile_image.dart';

class StoryTile extends StatelessWidget {
  const StoryTile({required this.user, required this.stories, Key? key})
      : super(key: key);
  final List<Story> stories;
  final AppUser user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute<StoriesViewScreen>(
            builder: (_) => StoriesViewScreen(stories: stories, user: user),
          ),
        );
      },
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
        user.displayName ?? 'Name fetching issue',
      ),
      subtitle: Text(
        Utilities.timeInWords(stories[stories.length - 1].timestamp),
      ),
    );
  }
}
