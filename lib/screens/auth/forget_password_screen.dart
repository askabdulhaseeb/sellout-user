import 'package:flutter/material.dart';
import 'package:sellout/utilities/app_images.dart';
import 'package:sellout/utilities/custom_validators.dart';
import 'package:sellout/utilities/utilities.dart';
import 'package:sellout/widgets/custom_elevated_button.dart';
import 'package:sellout/widgets/custom_textformfield.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);
  static const String routeName = '/ForgetPasswordScreen';
  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: Padding(
        padding: EdgeInsets.all(Utilities.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: SizedBox(
                height: 140,
                width: 140,
                child: Image.asset(AppImages.logo),
              ),
            ),
            const SizedBox(height: 30),
            _titleText('EMAIL ADDRESS'),
            CustomTextFormField(
              controller: _email,
              hint: 'test@test.com',
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              validator: (String? value) => CustomValidator.email(value),
            ),
            // const SizedBox(height: 10),
            const Text(
              'Please enter your email address to reset your password',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            CustomElevatedButton(
              title: 'Reset Password',
              onTap: () {
                // TODO: Reset Button code
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  '''Already have a account?''',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Sign In'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
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
