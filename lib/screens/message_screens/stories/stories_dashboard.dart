import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../database/auth_methods.dart';
import '../../../../../models/story.dart';
import '../../../../../services/user_local_data.dart';
import '../../../../../widgets/custom_widgets/custom_profile_image.dart';
import '../../../../../widgets/custom_widgets/show_loading.dart';
import '../../../../../widgets/messages/story_tile.dart';
import '../../../database/stories_api.dart';
import '../../../providers/user_provider.dart';
import 'add_media_story_screen.dart';
import 'my_stories_screen.dart';
import 'stories_view_screen.dart';

class StoriesDashboard extends StatelessWidget {
  const StoriesDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>?>(
          stream: StoriesAPI().getStories(),
          builder: (
            BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>?> snapshot,
          ) {
            if (snapshot.hasData) {
              final List<Story> allStories = <Story>[];
              for (QueryDocumentSnapshot<Map<String, dynamic>> element
                  in snapshot.data!.docs) {
                allStories.add(Story.fromDoc(element));
              }
              List<List<Story>> othersStories = <List<Story>>[];
              List<Story> myStoires = allStories
                  .where((Story myElement) => myElement.uid == AuthMethods.uid)
                  .cast<Story>()
                  .toList();
              for (String supportingUID in UserLocalData.getSupporting) {
                List<Story> oTempList = allStories
                    .where((Story oElement) => oElement.uid == supportingUID)
                    .cast<Story>()
                    .toList();
                if (oTempList.isNotEmpty) {
                  othersStories.add(oTempList);
                }
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _MyStoryTile(stories: myStoires),
                  const SizedBox(height: 10),
                  Text(
                    'Recent Updates',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Expanded(
                    child: othersStories.isEmpty
                        ? const Center(
                            child: Text('No story available yet'),
                          )
                        : Consumer<UserProvider>(
                            builder: (_, UserProvider value, __) =>
                                othersStories.isEmpty
                                    ? const Center(
                                        child: Text('No Story Available'),
                                      )
                                    : ListView.separated(
                                        itemCount: othersStories.length,
                                        separatorBuilder: (_, __) =>
                                            const Divider(height: 1),
                                        itemBuilder: (_, int index) {
                                          return StoryTile(
                                            user: value.user(
                                              uid:
                                                  othersStories[index][0].uid ??
                                                      '',
                                            ),
                                            stories: othersStories[index],
                                          );
                                        },
                                      ),
                          ),
                  ),
                ],
              );
            } else {
              return (snapshot.hasError)
                  ? const Center(
                      child: SelectableText('Facing some issue'),
                    )
                  : const ShowLoading();
            }
          }),
    );
  }
}

class _MyStoryTile extends StatelessWidget {
  const _MyStoryTile({required this.stories, Key? key}) : super(key: key);
  final List<Story> stories;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            (stories.isEmpty)
                ? Navigator.of(context).pushNamed(AddMediaStoryScreen.routeName)
                : Navigator.of(context).push(
                    MaterialPageRoute<StoriesViewScreen>(
                      builder: (_) => StoriesViewScreen(
                        stories: stories,
                        user: UserLocalData().user,
                      ),
                    ),
                  );
          },
          child: Container(
            padding: const EdgeInsets.all(1.5),
            decoration: BoxDecoration(
              border: Border.all(
                color: (stories.isEmpty)
                    ? Colors.grey
                    : Theme.of(context).primaryColor,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: CustomProfileImage(imageURL: UserLocalData.getImageURL),
          ),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute<MyStoiresScreen>(
              builder: (_) => MyStoiresScreen(stories: stories),
            ));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Text(
                'My Stories',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'Share your stories here',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              )
            ],
          ),
        ),
        const Spacer(),
        IconButton(
          splashRadius: 24,
          onPressed: () async {
            Navigator.of(context).pushNamed(AddMediaStoryScreen.routeName);
          },
          icon: Icon(
            Icons.camera_alt_outlined,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }
}
