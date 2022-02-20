import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../../database/auth_methods.dart';
import '../../../database/stories_api.dart';
import '../../../enums/messages/story_media_type_enum.dart';
import '../../../models/story.dart';
import '../../../widgets/custom_widgets/custom_textformfield.dart';
import '../../../widgets/custom_widgets/custom_toast.dart';
import '../../../widgets/custom_widgets/show_loading.dart';

class AddMediaStoryScreen extends StatefulWidget {
  const AddMediaStoryScreen({Key? key}) : super(key: key);
  static const String routeName = '/AddMediaStoryScreen';
  @override
  State<AddMediaStoryScreen> createState() => _AddMediaStoryScreenState();
}

class _AddMediaStoryScreenState extends State<AddMediaStoryScreen> {
  final TextEditingController _caption = TextEditingController();
  PlatformFile? _file;
  bool _isUploading = false;

  @override
  void initState() {
    _pickfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: (_file == null)
                ? const SizedBox()
                : Image.file(
                    File(_file!.path!),
                  ),
          ),
          Positioned(
              top: 24,
              left: 8,
              child: _isUploading
                  ? const SizedBox()
                  : CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      child: IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.clear),
                      ),
                    )),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Row(
              children: <Widget>[
                Flexible(
                  child: CustomTextFormField(
                    controller: _caption,
                    readOnly: _isUploading,
                    validator: (String? value) => null,
                    hint: 'Write your caption here ...',
                    maxLines: 4,
                  ),
                ),
                const SizedBox(width: 10),
                _isUploading
                    ? const ShowLoading()
                    : GestureDetector(
                        onTap: () => _uploadFile(),
                        child: CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColor,
                          child: const Icon(Icons.publish, color: Colors.white),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _pickfile() async {
    final FilePickerResult? _result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (_result == null) {
      Navigator.of(context).pop();
    } else {
      _file = _result.files.first;
      setState(() {});
    }
  }

  _uploadFile() async {
    setState(() {
      _isUploading = true;
    });
    final String? _url =
        await StoriesAPI().uploadImage(file: File(_file!.path!));
    if (_url == null) {
      return;
    }
    final int _time = DateTime.now().microsecondsSinceEpoch;
    final Story _story = Story(
      sid: '${AuthMethods.uid}$_time',
      url: _url,
      timestamp: _time,
      type: StoryMediaTypeEnum.PHOTO,
      caption: _caption.text.trim(),
      uid: AuthMethods.uid,
    );
    final bool _uploaded = await StoriesAPI().addStory(story: _story);
    setState(() {
      _isUploading = false;
    });
    if (_uploaded) {
      Navigator.of(context).pop();
      CustomToast.successSnackBar(
        context: context,
        text: 'Story successfully added',
      );
    }
  }
}
