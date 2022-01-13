import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellout/screens/main_screen/pages/my_profile_page.dart';
import '../../providers/main_bottom_nav_bar_provider.dart';
import 'main_bottom_navigation_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  static const String rotueName = '/MainScrenn';
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  static const List<Widget> _pages = <Widget>[
    Center(child: Text('Home')),
    Center(child: Text('Cart')),
    Center(child: Text('Add')),
    Center(child: Text('Chat')),
    MyProdilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    int _currentIndex =
        Provider.of<MainBottomNavBarProvider>(context).currentTap;
    return Scaffold(
        body: _pages[_currentIndex],
        bottomNavigationBar: const MainBottomNavigationBar());
  }
}
