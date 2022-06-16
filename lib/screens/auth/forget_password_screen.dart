import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../database/auth_methods.dart';
import '../../enums/screen_state_enum.dart';
import '../../providers/auth_state_provider.dart';
import '../../services/custom_services.dart';
import '../../utilities/app_images.dart';
import '../../utilities/custom_validators.dart';
import '../../utilities/utilities.dart';
import '../../widgets/custom_widgets/custom_elevated_button.dart';
import '../../widgets/custom_widgets/custom_textformfield.dart';
import '../../widgets/custom_widgets/custom_toast.dart';
import '../../widgets/custom_widgets/show_loading.dart';
import 'login_screen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);
  static const String routeName = '/ForgetPasswordScreen';
  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _email = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final AuthStateProvider state = Provider.of<AuthStateProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        systemOverlayStyle: CustomService.systemUIOverlayStyle(),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(Utilities.padding),
        child: Form(
          key: _key,
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
              state.currentState == ScreenStateEnum.WAITING
                  ? const ShowLoading()
                  : CustomElevatedButton(
                      title: 'Reset Password',
                      onTap: () => _submitForm(state),
                    ),
              state.currentState == ScreenStateEnum.WAITING
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
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Sign In'),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submitForm(AuthStateProvider state) async {
    if (_key.currentState!.validate()) {
      state.updateState(ScreenStateEnum.WAITING);
      final bool sended = await AuthMethods().forgetPassword(_email.text);
      state.resetState();
      if (sended) {
        CustomToast.successSnackBar(
            context: context, text: 'Email send at ${_email.text.trim()}');
        if (!mounted) return;
        Navigator.of(context).pushNamedAndRemoveUntil(
            LoginScreen.routeName, (Route<dynamic> route) => false);
      }
    }
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
