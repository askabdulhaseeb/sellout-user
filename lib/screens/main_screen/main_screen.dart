import 'package:flutter/material.dart';
import 'package:sellout/services/user_local_data.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  static const String rotueName = '/MainScrenn';
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(UserLocalData.getDisplayName),
      ),
    );
  }
}
