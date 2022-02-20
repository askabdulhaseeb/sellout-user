import 'package:flutter/material.dart';

import '../database/user_api.dart';
import '../models/app_user.dart';

class AppProvider extends ChangeNotifier {
  final List<AppUser> _user = <AppUser>[];

  void init() async {
    if (_user.isNotEmpty) return; //TODO: modify it
    _user.addAll(await UserAPI().getAllUsers());
    print('App_Provider.dart: No of Users: ${_user.length}');
  }

  List<AppUser> get users => <AppUser>[..._user];

  AppUser user({required String uid}) {
    int index = _user.indexWhere((AppUser element) => element.uid == uid);
    if (index < 0) {
      _fetchData(uid);
      index = _user.indexWhere((AppUser element) => element.uid == uid);
    }
    return _user[index];
  }

  void _fetchData(String uid) async {
    final AppUser? _userInfo = await UserAPI().getInfo(uid: uid);
    _user.add(_userInfo!);
    notifyListeners();
  }
}
