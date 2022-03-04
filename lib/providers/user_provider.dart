import 'package:flutter/material.dart';

import '../database/auth_methods.dart';
import '../database/user_api.dart';
import '../models/app_user.dart';
import '../services/user_local_data.dart';

class UserProvider extends ChangeNotifier {
  final List<AppUser> _user = <AppUser>[];

  void init() async {
    if (_user.isNotEmpty) return;
    _user.addAll(await UserAPI().getAllUsers());
    UserLocalData().storeAppUserData(
        appUser: _user.firstWhere(
      (AppUser element) => element.uid == AuthMethods.uid,
    ));
    print('App_Provider.dart: No of Users: ${_user.length}');
  }

  void refresh() async {
    _user.clear();
    _user.addAll(await UserAPI().getAllUsers());
    UserLocalData().storeAppUserData(
        appUser: _user.firstWhere(
      (AppUser element) => element.uid == AuthMethods.uid,
    ));
  }

  void reset() {
    _user.clear();
  }

  List<AppUser> supporters({required String uid}) {
    List<AppUser> _supporters = <AppUser>[];
    int index = _indexOf(uid);
    final AppUser _tempUser = _user[index];
    if (index >= 0) {
      for (String element in _tempUser.supporters!) {
        _supporters.add(_user[_indexOf(element)]);
      }
    }
    return _supporters;
  }

  List<AppUser> usersFromListOfString({required List<String> uidsList}) {
    List<AppUser> _tempList = <AppUser>[];
    for (String element in uidsList) {
      _tempList.add(_user[_indexOf(element)]);
    }
    return _tempList;
  }

  List<AppUser> supportings({required String uid}) {
    List<AppUser> _supporting = <AppUser>[];
    int index = _indexOf(uid);
    final AppUser _tempUser = _user[index];
    if (index >= 0) {
      for (String element in _tempUser.supporting!) {
        _supporting.add(_user[_indexOf(element)]);
      }
    }
    return _supporting;
  }

  List<AppUser> get users => <AppUser>[..._user];

  AppUser user({required String uid}) {
    int index = _indexOf(uid);
    return _user[index];
  }

  void _fetchData(String uid) async {
    final AppUser? _userInfo = await UserAPI().getInfo(uid: uid);
    _user.add(_userInfo!);
    notifyListeners();
  }

  int _indexOf(String uid) {
    int index = _user.indexWhere((AppUser element) => element.uid == uid);
    if (index < 0) {
      _fetchData(uid);
      index = _user.indexWhere((AppUser element) => element.uid == uid);
    }
    return index;
  }
}
