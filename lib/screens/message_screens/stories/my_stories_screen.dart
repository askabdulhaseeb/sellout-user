import 'package:flutter/material.dart';

import '../../../models/story.dart';
import '../../../utilities/utilities.dart';
import '../../../widgets/custom_widgets/custom_profile_image.dart';

class MyStoiresScreen extends StatelessWidget {
  const MyStoiresScreen({required this.stories, Key? key}) : super(key: key);
  final List<Story> stories;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Stories'),
        titleSpacing: 0,
      ),
      body: ListView.separated(
        itemCount: stories.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (_, int index) => ListTile(
          leading: CustomProfileImage(imageURL: stories[index].url),
          title: Text('${stories[index].views?.length ?? 0} views'),
          subtitle: Text(Utilities.timeInWords(stories[index].timestamp)),
          trailing: IconButton(
            splashRadius: 20,
            onPressed: () {
              //TODO: delete stories
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
