import 'package:flutter/material.dart';
import 'package:sellout/screens/auth/auth_type_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SellOut',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AuthTypeScreen(),
      routes: <String, WidgetBuilder>{
        AuthTypeScreen.routeName: (BuildContext ctx) => const AuthTypeScreen(),
      },
    );
  }
}
