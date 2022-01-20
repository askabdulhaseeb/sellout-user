import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../database/auth_methods.dart';
import '../../enums/screen_state_enum.dart';
import '../../providers/auth_state_provider.dart';
import '../../providers/main_bottom_nav_bar_provider.dart';
import '../../services/custom_services.dart';
import '../../utilities/app_images.dart';
import '../../utilities/custom_validators.dart';
import '../../utilities/utilities.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_textformfield.dart';
import '../../widgets/password_textformfield.dart';
import '../../widgets/show_info_dialog.dart';
import '../../widgets/show_loading.dart';
import '../main_screen/main_screen.dart';
import 'forget_password_screen.dart';
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
    final AuthStateProvider _state = Provider.of<AuthStateProvider>(context);
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
              _state.currentState == ScreenStateEnum.WAITING
                  ? const ShowLoading()
                  : CustomElevatedButton(
                      title: 'Log In',
                      onTap: () => _submitForm(),
                    ),
              _forgetPassword(_state),
              const Spacer(),
              const SizedBox(height: 16),
              _otherAuthMethods(_state),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submitForm() async {
    if (_key.currentState!.validate()) {
      CustomService.dismissKeyboard();
      Provider.of<AuthStateProvider>(context, listen: false)
          .updateState(ScreenStateEnum.WAITING);
      final User? _user = await AuthMethods().loginWithEmailAndPassword(
        _email.text,
        _password.text,
      );
      Provider.of<AuthStateProvider>(context, listen: false)
          .updateState(ScreenStateEnum.DONE);
      if (_user != null) {
        Provider.of<MainBottomNavBarProvider>(context, listen: false)
            .onTabTapped(0);
        Navigator.of(context).pushNamedAndRemoveUntil(
            MainScreen.rotueName, (Route<dynamic> route) => false);
      }
    }
  }

  Column _otherAuthMethods(AuthStateProvider state) {
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
              isDisable: state.currentState != ScreenStateEnum.DONE,
              icon: Icon(FontAwesomeIcons.facebookF,
                  color: state.currentState != ScreenStateEnum.DONE
                      ? Colors.grey
                      : Colors.blue),
              onTap: () {
                //TODO: Login with facebook

                // state.updateState(ScreenStateEnum.WAITING);
                showInfoDialog(context);
                // state.resetState();
              },
            ),
            _SocialMediaLoginButton(
              text: 'Google',
              isDisable: state.currentState != ScreenStateEnum.DONE,
              icon: Icon(FontAwesomeIcons.google,
                  color: state.currentState != ScreenStateEnum.DONE
                      ? Colors.grey
                      : Colors.red),
              // onTap: () async {
              //   state.updateState(ScreenStateEnum.WAITING);
              //   final bool _okay = await AuthMethods().signinWithGoogle();
              //   if (_okay) {
              //     Navigator.of(context).pushNamedAndRemoveUntil(
              //         MainScreen.rotueName, (Route<dynamic> route) => false);
              //   }
              //   state.resetState();
              // },
              onTap: () {
                //TODO: Login with Google

                // state.updateState(ScreenStateEnum.WAITING);
                showInfoDialog(context);
                // state.resetState();
              },
            ),
            _SocialMediaLoginButton(
              text: 'Apple',
              isDisable: state.currentState != ScreenStateEnum.DONE,
              icon: Icon(FontAwesomeIcons.apple,
                  color: state.currentState != ScreenStateEnum.DONE
                      ? Colors.grey
                      : Colors.black),
              onTap: () {
                // TODO: Login with Apple
                // state.updateState(ScreenStateEnum.WAITING);
                showInfoDialog(context);
                // state.resetState();
              },
            ),
          ],
        ),
        state.currentState == ScreenStateEnum.WAITING
            ? const SizedBox(height: 40)
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    '''Don't have an account?''',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Provider.of<AuthStateProvider>(context, listen: false)
                          .resetState();
                      Navigator.of(context)
                          .pushReplacementNamed(RegisterScreen.routeName);
                    },
                    child: const Text('Register'),
                  ),
                ],
              ),
      ],
    );
  }

  TextButton _forgetPassword(AuthStateProvider state) {
    return TextButton(
      onPressed: () {
        if (state.currentState != ScreenStateEnum.WAITING) {
          Navigator.of(context).pushNamed(ForgetPasswordScreen.routeName);
        }
      },
      child: Text(
        'Forget Password?',
        style: TextStyle(
          color: state.currentState == ScreenStateEnum.WAITING
              ? Colors.grey
              : Colors.black,
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
    this.isDisable = false,
    Key? key,
  }) : super(key: key);
  final String text;
  final Icon icon;
  final VoidCallback onTap;
  final bool isDisable;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isDisable ? () {} : onTap,
      borderRadius: BorderRadius.circular(Utilities.borderRadius / 2),
      child: Padding(
        padding: EdgeInsets.all(Utilities.padding),
        child: Column(
          children: <Widget>[
            icon,
            const SizedBox(height: 6),
            Text(
              text,
              style: isDisable
                  ? const TextStyle(color: Colors.grey)
                  : const TextStyle(),
            )
          ],
        ),
      ),
    );
  }
}
