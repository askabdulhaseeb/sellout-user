import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/main_bottom_nav_bar_provider.dart';

class MainBottomNavigationBar extends StatelessWidget {
  const MainBottomNavigationBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    AppProvider navBar = Provider.of<AppProvider>(context);
    return BottomNavigationBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      selectedLabelStyle: TextStyle(color: Theme.of(context).primaryColor),
      selectedItemColor: Theme.of(context).primaryColor,
      showUnselectedLabels: false,
      showSelectedLabels: false,
      unselectedItemColor: Colors.grey,
      currentIndex: navBar.currentTap,
      onTap: (int index) => navBar.onTabTapped(index),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home_rounded),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart_outlined),
          activeIcon: Icon(Icons.shopping_cart),
          label: 'Cart',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_box_outlined),
          activeIcon: Icon(Icons.add_box),
          label: 'Add',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_outlined),
          activeIcon: Icon(Icons.chat),
          label: 'chat',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_box_outlined),
          activeIcon: Icon(Icons.account_box),
          label: 'Profile',
        ),
      ],
    );
  }
}
