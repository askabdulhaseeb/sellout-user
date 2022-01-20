import 'package:flutter/material.dart';

class MainBottomNavBarProvider extends ChangeNotifier {
  int _currentIndex = 0;
  void onTabTapped(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  int get currentTap => _currentIndex;
}
