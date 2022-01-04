import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:sellout/utilities/app_images.dart';
import 'package:sellout/utilities/utilities.dart';
import 'package:sellout/widgets/custom_elevated_button.dart';
import 'package:sellout/widgets/custom_textformfield.dart';
import 'package:sellout/widgets/password_textformfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const String routeName = '/LoginScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(Utilities.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 40),
            Center(
              child: SizedBox(
                height: 140,
                width: 140,
                child: Image.asset(AppImages.iconBorder),
              ),
            ),
            const SizedBox(height: 60),
            _titleText('EMAIL ADDRESS'),
            CustomTextFormField(controller: _email),
            const SizedBox(height: 6),
            _titleText('PASSWORD'),
            PasswordTextFormField(controller: _password),
            const SizedBox(height: 20),
            CustomElevatedButton(
              title: 'Log In',
              onTap: () {},
            ),
            _forgetPassword(),
            const Spacer(),
            _otherAuthMethods(),
          ],
        ),
      ),
    );
  }

  Column _otherAuthMethods() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        // const Text('OR'),
        // const SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _SocialMediaLoginButton(
              text: 'Facebook',
              icon: const Icon(FontAwesomeIcons.facebookF, color: Colors.blue),
              onTap: () {},
            ),
            _SocialMediaLoginButton(
              text: 'Google',
              icon: const Icon(FontAwesomeIcons.google, color: Colors.red),
              onTap: () {},
            ),
            _SocialMediaLoginButton(
              text: 'Apple',
              icon: const Icon(FontAwesomeIcons.apple, color: Colors.black),
              onTap: () {},
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              '''Don't have an account?''',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Register'),
            ),
          ],
        )
      ],
    );
  }

  TextButton _forgetPassword() {
    return TextButton(
      onPressed: () {},
      child: const Text(
        'Forget Password?',
        style: TextStyle(
          color: Colors.black,
          decoration: TextDecoration.underline,
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

class _SocialMediaLoginButton extends StatelessWidget {
  const _SocialMediaLoginButton({
    required this.text,
    required this.icon,
    required this.onTap,
    Key? key,
  }) : super(key: key);
  final String text;
  final Icon icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[icon, const SizedBox(height: 6), Text(text)],
        ),
      ),
    );
  }
}
