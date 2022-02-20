import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import '../../../models/app_user.dart';
import '../../../models/stories.dart';
import '../../../utilities/utilities.dart';
import '../../../widgets/custom_widgets/custom_profile_image.dart';

class StoriesViewScreen extends StatelessWidget {
  const StoriesViewScreen({required this.stories, required this.user, Key? key})
      : super(key: key);
  final List<Stories> stories;
  final AppUser user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: ExtendedImage.network(
              stories[0].url,
              cacheMaxAge: const Duration(days: 1),
            ),
          ),
          Positioned(
            top: 12,
            left: 0,
            right: 16,
            child: Row(
              children: <Widget>[
                IconButton(
                  splashRadius: 20,
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(
                    Icons.arrow_back_ios_new_outlined,
                    color: Colors.white,
                  ),
                ),
                CustomProfileImage(imageURL: user.imageURL ?? ''),
                const SizedBox(width: 4),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        user.displayName ?? 'Name fetching issue',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        Utilities.timeInDigits(stories[0].timestamp),
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: Text(
              stories[0].title ?? '',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
