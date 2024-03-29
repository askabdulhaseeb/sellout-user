import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../../database/auth_methods.dart';
import '../../database/user_api.dart';
import '../../models/app_user.dart';
import '../../services/user_local_data.dart';
import '../../utilities/custom_validators.dart';
import '../../widgets/custom_widgets/custom_elevated_button.dart';
import '../../widgets/custom_widgets/custom_file_image_box.dart';
import '../../widgets/custom_widgets/custom_network_change_img_box.dart';
import '../../widgets/custom_widgets/custom_title_textformfield.dart';
import '../../widgets/custom_widgets/show_loading.dart';
import '../../widgets/profile_display_type.dart';
import '../main_screen/main_screen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);
  static const String routeName = 'EditProfileScreen';

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  PlatformFile? _pickedImage;
  final TextEditingController _name =
      TextEditingController(text: UserLocalData.getDisplayName);
  final TextEditingController _username =
      TextEditingController(text: UserLocalData.getUsername);
  final TextEditingController _bio =
      TextEditingController(text: UserLocalData.getBio);
  final TextEditingController _category = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  bool _profileDisplay = true;
  bool _isloading = false;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: const Text(
          'Edit Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Column(
            children: <Widget>[
              _pickedImage == null
                  ? CustomNetworkChangeImageBox(
                      url: UserLocalData.getImageURL,
                      title: 'Change Profile Photo',
                      onTap: () => _fetchMedia(),
                    )
                  : CustomFileImageBox(
                      file: _pickedImage,
                      title: 'Change Profile Photo',
                      onTap: () => _fetchMedia(),
                    ),
              const Divider(height: 4),
              CustomTitleTextFormField(
                controller: _name,
                title: 'Name',
                readOnly: _isloading,
                validator: (String? value) => CustomValidator.lessThen3(value),
              ),
              const Divider(height: 4),
              CustomTitleTextFormField(
                controller: _username,
                title: 'Username',
                readOnly: _isloading,
                validator: (String? value) => CustomValidator.lessThen5(value),
              ),
              const Divider(height: 4),
              CustomTitleTextFormField(
                controller: _bio,
                title: 'Bio',
                readOnly: _isloading,
                maxLines: 5,
                validator: (String? value) => CustomValidator.retaunNull(value),
                maxLength: 160,
              ),
              const Divider(height: 4),
              // TODO: Need to update this
              CustomTitleTextFormField(
                controller: _category,
                title: 'Category',
                readOnly: true,
                validator: (String? value) => CustomValidator.retaunNull(value),
              ),
              const Divider(height: 4),
              // TODO: Need to update this
              CustomTitleTextFormField(
                controller: _phone,
                title: 'Phone Number',
                readOnly: true,
                validator: (String? value) => CustomValidator.retaunNull(value),
              ),
              const Divider(height: 4),
              ProfileDisplayTypeWidget(
                isPublic: _profileDisplay,
                onChanged: (bool update) {
                  _profileDisplay = update;
                },
              ),
              const Divider(height: 4),
              _isloading
                  ? const ShowLoading()
                  : Padding(
                      padding: const EdgeInsets.all(32),
                      child: CustomElevatedButton(
                        title: 'Update',
                        onTap: () async {
                          if (_key.currentState!.validate()) {
                            setState(() {
                              _isloading = true;
                            });
                            String url = UserLocalData.getImageURL;
                            if (_pickedImage != null) {
                              String? tempURL = await UserAPI().uploadImage(
                                  File(_pickedImage!.path!), AuthMethods.uid);
                              url = tempURL;
                            }
                            AppUser appUser = AppUser(
                              uid: AuthMethods.uid,
                              displayName: _name.text,
                              username: _username.text,
                              bio: _bio.text,
                              isPublicProfile: _profileDisplay,
                              imageURL: url,
                            );
                            final bool updated =
                                await UserAPI().updateProfile(appUser);
                            if (updated) {
                              if (!mounted) return;
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  MainScreen.rotueName, (_) => false);
                            } else {
                              setState(() {
                                _isloading = false;
                              });
                            }
                          }
                        },
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }

  _fetchMedia() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result == null) return;
    _pickedImage = result.files.first;
    setState(() {});
  }
}
