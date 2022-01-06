import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sellout/database/auth_methods.dart';
import 'package:sellout/screens/auth/forget_password_screen.dart';
import 'package:sellout/screens/main_screen/main_screen.dart';
import 'package:sellout/widgets/show_loading.dart';
import '../../utilities/app_images.dart';
import '../../utilities/custom_validators.dart';
import '../../utilities/utilities.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_textformfield.dart';
import '../../widgets/password_textformfield.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const String routeName = '/LoginScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.all(Utilities.padding),
        child: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 40),
              Center(
                child: SizedBox(
                  height: 140,
                  width: 140,
                  child: Image.asset(AppImages.logo),
                ),
              ),
              const SizedBox(height: 60),
              _titleText('EMAIL ADDRESS'),
              CustomTextFormField(
                controller: _email,
                hint: 'test@test.com',
                keyboardType: TextInputType.emailAddress,
                validator: (String? value) => CustomValidator.email(value),
              ),
              const SizedBox(height: 6),
              _titleText('PASSWORD'),
              PasswordTextFormField(controller: _password),
              const SizedBox(height: 16),
              CustomElevatedButton(
                title: 'Log In',
                onTap: () => _submitForm(),
              ),
              _forgetPassword(),
              const Spacer(),
              _otherAuthMethods(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submitForm() async {
    if (_key.currentState!.validate()) {
      showLoadingDislog(context);
      final User? _user = await AuthMethods().loginWithEmailAndPassword(
        _email.text,
        _password.text,
      );
      if (_user != null) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            MainScreen.rotueName, (Route<dynamic> route) => false);
      } else {
        Navigator.of(context).pop();
      }
    }
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
              onTap: () {
                //TODO: Login with facebook
              },
            ),
            _SocialMediaLoginButton(
              text: 'Google',
              icon: const Icon(FontAwesomeIcons.google, color: Colors.red),
              onTap: () {
                //TODO: Login with Google
              },
            ),
            _SocialMediaLoginButton(
              text: 'Apple',
              icon: const Icon(FontAwesomeIcons.apple, color: Colors.black),
              onTap: () {
                // TODO: Login with Apple
              },
            ),
          ],
        ),
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
              onPressed: () => Navigator.of(context)
                  .pushReplacementNamed(RegisterScreen.routeName),
              child: const Text('Register'),
            ),
          ],
        ),
      ],
    );
  }

  TextButton _forgetPassword() {
    return TextButton(
      onPressed: () =>
          Navigator.of(context).pushNamed(ForgetPasswordScreen.routeName),
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
      borderRadius: BorderRadius.circular(Utilities.borderRadius / 2),
      child: Padding(
        padding: EdgeInsets.all(Utilities.padding),
        child: Column(
          children: <Widget>[icon, const SizedBox(height: 6), Text(text)],
        ),
      ),
    );
  }
}
