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
              final List<Story> _allStories = <Story>[];
              for (QueryDocumentSnapshot<Map<String, dynamic>> element
                  in snapshot.data!.docs) {
                _allStories.add(Story.fromDoc(element));
              }
              List<List<Story>> _othersStories = <List<Story>>[];
              print('Print: all Stories Length: ${_allStories.length} ');
              _allStories.forEach((element) => print(
                  'Print: ${element.uid}, ${element.uid == AuthMethods.uid}'));
              List<Story> _myStoires = _allStories
                  .where((Story myElement) => myElement.uid == AuthMethods.uid)
                  .cast<Story>()
                  .toList();
              print('Print: ${_myStoires.length}');
              for (String supportingUID in UserLocalData.getSupporting) {
                List<Story> _oTempList = _allStories
                    .where((Story oElement) => oElement.uid == supportingUID)
                    .cast<Story>()
                    .toList();
                if (_oTempList.isNotEmpty) {
                  _othersStories.add(_oTempList);
                }
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _MyStoryTile(stories: _myStoires),
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
                    child: _othersStories.isEmpty
                        ? const Center(
                            child: Text('No story available yet'),
                          )
                        : Consumer<UserProvider>(
                            builder: (_, UserProvider value, __) =>
                                _othersStories.isEmpty
                                    ? const Center(
                                        child: Text('No Story Available'),
                                      )
                                    : ListView.separated(
                                        itemCount: _othersStories.length,
                                        separatorBuilder: (_, __) =>
                                            const Divider(height: 1),
                                        itemBuilder: (_, int index) {
                                          return StoryTile(
                                            user: value.user(
                                              uid: _othersStories[index][0]
                                                      .uid ??
                                                  '',
                                            ),
                                            stories: _othersStories[index],
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

class _MyStoryTile extends StatefulWidget {
  const _MyStoryTile({required this.stories, Key? key}) : super(key: key);
  final List<Story> stories;
  @override
  State<_MyStoryTile> createState() => _MyStoryTileState();
}

class _MyStoryTileState extends State<_MyStoryTile> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            (widget.stories.isEmpty)
                ? Navigator.of(context).pushNamed(AddMediaStoryScreen.routeName)
                : Navigator.of(context).push(
                    MaterialPageRoute<StoriesViewScreen>(
                      builder: (_) => StoriesViewScreen(
                        stories: widget.stories,
                        user: UserLocalData().user,
                      ),
                    ),
                  );
          },
          child: Container(
            padding: const EdgeInsets.all(1.5),
            decoration: BoxDecoration(
              border: Border.all(
                color: (widget.stories.isEmpty)
                    ? Colors.grey
                    : Theme.of(context).primaryColor,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: CustomProfileImage(imageURL: UserLocalData.getImageURL),
          ),
        ),
        const SizedBox(width: 10),
        Column(
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
