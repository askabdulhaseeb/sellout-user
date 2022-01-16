import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:provider/provider.dart';
import '../../database/auth_methods.dart';
import '../../database/user_api.dart';
import '../../enums/screen_state_enum.dart';
import '../../models/app_user.dart';
import '../../providers/auth_state_provider.dart';
import '../../widgets/custom_toast.dart';
import '../../widgets/show_loading.dart';
import '../../utilities/app_images.dart';
import '../../utilities/custom_validators.dart';
import '../../utilities/utilities.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_textformfield.dart';
import '../../widgets/dob_dropdown.dart';
import '../../widgets/gender_selection_button.dart';
import '../../widgets/password_textformfield.dart';
import '../../widgets/phone_number_field.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  static const String routeName = '/RegisterScreen';
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  PhoneNumber? _number;
  GenderTypes _gender = GenderTypes.MALE;
  DateOfBirth _dob = DateOfBirth(date: 0, month: 0, year: 0);
  @override
  Widget build(BuildContext context) {
    final AuthStateProvider _state = Provider.of<AuthStateProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _key,
        child: Padding(
          padding: EdgeInsets.all(Utilities.padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
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
                      _titleText('FULL NAME'),
                      CustomTextFormField(
                        controller: _fullName,
                        keyboardType: TextInputType.name,
                        validator: (String? value) =>
                            CustomValidator.lessThen3(value),
                      ),
                      _titleText('USERNAME'),
                      CustomTextFormField(
                        controller: _username,
                        keyboardType: TextInputType.emailAddress,
                        validator: (String? value) =>
                            CustomValidator.lessThen3(value),
                      ),
                      const SizedBox(height: 10),
                      _titleText('GENDER'),
                      GenderSectionButton(
                        onChanged: (GenderTypes? gender) => _gender = gender!,
                      ),
                      _titleText('DATE OF BIRTH'),
                      DOBDropdown(
                        onChanged: (DateOfBirth dob) {
                          _dob = dob;
                        },
                      ),
                      PhoneNumberField(
                        onChange: (PhoneNumber number) => _number = number,
                      ),
                      const SizedBox(height: 10),
                      _titleText('EMAIL'),
                      CustomTextFormField(
                        controller: _email,
                        hint: 'test@test.com',
                        keyboardType: TextInputType.emailAddress,
                        validator: (String? value) =>
                            CustomValidator.email(value),
                      ),
                      _titleText('PASSWORD'),
                      PasswordTextFormField(
                        controller: _password,
                        textInputAction: TextInputAction.next,
                      ),
                      _titleText('CONFIRM PASSWORD'),
                      PasswordTextFormField(controller: _confirmPassword),
                      const SizedBox(height: 10),
                      _state.currentState == ScreenStateEnum.WAITING
                          ? const ShowLoading()
                          : CustomElevatedButton(
                              title: 'Register',
                              onTap: () => _submitForm(_state),
                            ),
                      const SizedBox(height: 160),
                    ],
                  ),
                ),
              ),
              _state.currentState == ScreenStateEnum.WAITING
                  ? const SizedBox()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          '''Already have a account?''',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Provider.of<AuthStateProvider>(context,
                                    listen: false)
                                .resetState();
                            Navigator.of(context)
                                .pushReplacementNamed(LoginScreen.routeName);
                          },
                          child: const Text('Sign In'),
                        ),
                      ],
                    ),
              const Text(
                'By registering you accept Customer Agreement conditions and privacy policy',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm(AuthStateProvider state) async {
    if (_key.currentState!.validate()) {
      if (_password.text != _confirmPassword.text) {
        CustomToast.errorToast(
          message: 'Password and Confirm password is not same',
        );
        return;
      } else if (_dob.isValid == false) {
        CustomToast.errorToast(
          message: 'Date of Birth is missing!',
        );
        return;
      }
      state.updateState(ScreenStateEnum.WAITING);
      final User? _myUser = await AuthMethods().signupWithEmailAndPassword(
        email: _email.text,
        password: _password.text,
      );
      if (_myUser != null) {
        final AppUser _appUser = AppUser(
          uid: _myUser.uid,
          displayName: _fullName.text.trim(),
          username: _username.text.trim(),
          gender: _gender,
          dob: _dob.dob,
          countryCode: _number!.countryCode!,
          phoneNumber: _number!.number!,
          email: _email.text.trim(),
        );
        final bool _okay = await UserAPI().addUser(_appUser);
        state.resetState();
        if (_okay) {
          CustomToast.successToast(message: 'Register Successfully');
          Navigator.of(context).pushNamedAndRemoveUntil(
            LoginScreen.routeName,
            (Route<dynamic> route) => false,
          );
        }
      }
    }
    state.resetState();
  }

  Padding _titleText(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Text(
        ' $title',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
