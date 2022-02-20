import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extended_image/extended_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../../../../../database/auth_methods.dart';
import '../../../../../database/stories_api.dart';
import '../../../../../models/stories.dart';
import '../../../../../services/user_local_data.dart';
import '../../../../../widgets/custom_widgets/custom_profile_image.dart';
import '../../../../../widgets/custom_widgets/custom_toast.dart';
import '../../../../../widgets/custom_widgets/show_loading.dart';
import '../../../../../widgets/messages/story_tile.dart';

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
              final List<Stories> _allStories = <Stories>[];
              for (QueryDocumentSnapshot<Map<String, dynamic>> element
                  in snapshot.data!.docs) {
                _allStories.add(Stories.fromDoc(element));
              }
              List<List<Stories>> _othersStories = <List<Stories>>[];
              List<Stories> _myStoires = <Stories>[];
              _myStoires = _allStories
                  .where((Stories element) => element.uid == AuthMethods.uid)
                  .cast<Stories>()
                  .toList();
              _othersStories.add(_myStoires);
              for (String uid in UserLocalData.getSupporting) {
                _othersStories.add(_allStories
                    .where((Stories element) => element.uid == uid)
                    .cast<Stories>()
                    .toList());
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _MyStoryTile(stories: _myStoires),
                  const SizedBox(height: 6),
                  Text(
                    'Recent Updates',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Expanded(
                    child: ListView.separated(
                        itemCount: _othersStories.length,
                        separatorBuilder: (_, __) => const Divider(height: 1),
                        itemBuilder: (_, int index) {
                          return StoryTile(stories: _othersStories[index]);
                        }),
                  ),
                ],
              );
            } else {
              return (snapshot.hasError)
                  ? const Center(
                      child: Text('Facing some issue'),
                    )
                  : const ShowLoading();
            }
          }),
    );
  }
}

class _MyStoryTile extends StatefulWidget {
  const _MyStoryTile({required this.stories, Key? key}) : super(key: key);
  final List<Stories> stories;
  @override
  State<_MyStoryTile> createState() => _MyStoryTileState();
}

class _MyStoryTileState extends State<_MyStoryTile> {
  PlatformFile? _file;
  bool _isUploading = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(1.5),
          decoration: BoxDecoration(
            border: Border.all(
                color: (widget.stories.isEmpty)
                    ? Colors.grey
                    : Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(12),
          ),
          child: CustomProfileImage(imageURL: UserLocalData.getImageURL),
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
        _isUploading
            ? const ShowLoading()
            : IconButton(
                splashRadius: 24,
                onPressed: () async {
                  final FilePickerResult? _result =
                      await FilePicker.platform.pickFiles(type: FileType.media);
                  if (_result == null) return;
                  setState(() {
                    _isUploading = true;
                  });
                  _file = _result.files.first;
                  final String? _url =
                      await StoriesAPI().uploadImage(file: File(_file!.path!));
                  if (_url == null) {
                    return;
                  }
                  final int _time = DateTime.now().microsecondsSinceEpoch;
                  final Stories _story = Stories(
                    sid: _time.toString(),
                    url: _url,
                    isVideo: false,
                    timestamp: _time,
                    title:
                        'Title of this stories. Search for Uk Writing Services on GigaPromo. Compare and save now! Large Selection. Always Sale. Cheap Prices. Full Offer. Save Online. Compare Online. Simple Search. The Best Price. Compare Simply. Services: Compare, Search, Find Products, Many Offers.',
                    uid: AuthMethods.uid,
                  );
                  final bool _uploaded =
                      await StoriesAPI().addStory(story: _story);
                  setState(() {
                    _isUploading = false;
                  });
                  if (_uploaded) {
                    CustomToast.successSnackBar(
                      context: context,
                      text: 'Story successfully added',
                    );
                  }
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
