import 'package:flutter/material.dart';
import '../enums/messages/message_tabbar_enum.dart';

class MessagePageProvider extends ChangeNotifier {
  //
  // Search Text Form Field
  //
  String _search = '';
  void updateSearch(String? update) {
    _search = update ?? '';
    notifyListeners();
  }

  String get search => _search;

  //
  // Tab Bar
  //

  MessageTabBarEnum _tab = MessageTabBarEnum.CHATS;
  void updateTab(MessageTabBarEnum upate) {
    _tab = upate;
    notifyListeners();
  }

  MessageTabBarEnum get currentTab => _tab;

  //
  //
  //
}
