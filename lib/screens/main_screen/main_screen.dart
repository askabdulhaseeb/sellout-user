import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/prod_provider.dart';
import '../../providers/user_provider.dart';
import '../../services/custom_services.dart';
import '../../providers/main_bottom_nav_bar_provider.dart';
import '../bet_screen/bet_screen.dart';
import 'main_bottom_navigation_bar.dart';
import 'pages/add_page.dart';
import 'pages/message_page.dart';
import 'pages/my_profile_page.dart';
import 'pages/home_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  static const String rotueName = '/MainScrenn';
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    CustomService.statusBar();
    super.initState();
  }

  static const List<Widget> _pages = <Widget>[
    HomePage(),
    BetScreen(),
    AddPage(),
    MessagePage(),
    MyProdilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    int _currentIndex = Provider.of<AppProvider>(context).currentTap;
    Provider.of<UserProvider>(context).init();
    Provider.of<ProdProvider>(context).init();
    return Scaffold(
        body: _pages[_currentIndex],
        bottomNavigationBar: const MainBottomNavigationBar());
  }
}
