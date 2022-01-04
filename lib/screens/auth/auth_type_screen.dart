import 'package:flutter/material.dart';
import 'package:sellout/screens/auth/login_screen.dart';
import 'package:sellout/utilities/app_images.dart';
import 'package:sellout/utilities/utilities.dart';
import 'package:sellout/widgets/custom_elevated_button.dart';

class AuthTypeScreen extends StatelessWidget {
  const AuthTypeScreen({Key? key}) : super(key: key);
  static const String routeName = '/AuthTypeScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Padding(
        padding: EdgeInsets.all(Utilities.padding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 200,
              width: 200,
              child: Image.asset(AppImages.iconSimple),
            ),
            CustomElevatedButton(
              title: 'Login',
              onTap: () => Navigator.of(context)
                  .pushReplacementNamed(LoginScreen.routeName),
              bgColor: Colors.white,
              borderRadius: BorderRadius.circular(10),
              textStyle: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            CustomElevatedButton(
              onTap: () {},
              title: 'Register',
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
