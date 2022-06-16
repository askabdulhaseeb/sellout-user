import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../../../../../database/group_chat_api.dart';
import '../../../../../models/group_chat.dart';
import '../../../../../utilities/custom_validators.dart';
import '../../../../../utilities/utilities.dart';
import '../../../../../widgets/custom_widgets/custom_elevated_button.dart';
import '../../../../../widgets/custom_widgets/custom_file_image_box.dart';
import '../../../../../widgets/custom_widgets/custom_textformfield.dart';
import '../../../../../widgets/custom_widgets/custom_toast.dart';
import '../../../../../widgets/custom_widgets/show_loading.dart';

class CreateChatGroupScreen extends StatefulWidget {
  const CreateChatGroupScreen({Key? key}) : super(key: key);
  static const String routeName = '/CreateChatGroupScreen';
  @override
  State<CreateChatGroupScreen> createState() => _CreateChatGroupScreenState();
}

class _CreateChatGroupScreenState extends State<CreateChatGroupScreen> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  PlatformFile? _pickedImage;
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(
          'Create Group',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Utilities.padding),
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CustomFileImageBox(
                  file: _pickedImage,
                  onTap: () => _uploadImage(),
                ),
                _titleText('Group Name'),
                CustomTextFormField(
                  controller: _name,
                  readOnly: _isLoading,
                  hint: 'A short name of your group',
                  validator: (String? value) =>
                      CustomValidator.lessThen2(value),
                ),
                const SizedBox(height: 6),
                _titleText('Group Description'),
                CustomTextFormField(
                  controller: _description,
                  readOnly: _isLoading,
                  hint: 'Add group description',
                  maxLines: 4,
                  validator: (String? value) =>
                      CustomValidator.retaunNull(value),
                ),
                const SizedBox(height: 10),
                _isLoading
                    ? const ShowLoading()
                    : CustomElevatedButton(
                        title: 'Create Group',
                        onTap: () async {
                          if (_key.currentState!.validate()) {
                            setState(() {
                              _isLoading = true;
                            });
                            String url = '';
                            if (_pickedImage != null) {
                              String? tempURL =
                                  await GroupChatAPI().uploadGroupImage(
                                file: File(_pickedImage!.path!),
                              );
                              url = tempURL ?? '';
                            }
                            GroupChat group = GroupChat(
                              name: _name.text,
                              description: _description.text,
                              imageURL: url,
                            );
                            final bool uploaded =
                                await GroupChatAPI().createGroup(group);
                            setState(() {
                              _isLoading = false;
                            });
                            if (uploaded) {
                              CustomToast.successToast(
                                  message: 'New Group Created');
                              if (!mounted) return;
                              Navigator.of(context).pop();
                            }
                          }
                        },
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _uploadImage() async {
    if (_isLoading == true) return;
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result == null) return;
    _pickedImage = result.files[0];
    setState(() {});
  }

  Text _titleText(String title) {
    return Text(
      ' $title',
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
