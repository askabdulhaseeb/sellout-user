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
    List<AppUser> supporters = <AppUser>[];
    int index = _indexOf(uid);
    final AppUser tempUser = _user[index];
    if (index >= 0) {
      for (String element in tempUser.supporters!) {
        supporters.add(_user[_indexOf(element)]);
      }
    }
    return supporters;
  }

  List<AppUser> usersFromListOfString({required List<String> uidsList}) {
    List<AppUser> tempList = <AppUser>[];
    for (String element in uidsList) {
      tempList.add(_user[_indexOf(element)]);
    }
    return tempList;
  }

  List<AppUser> supportings({required String uid}) {
    List<AppUser> supporting = <AppUser>[];
    int index = _indexOf(uid);
    final AppUser tempUser = _user[index];
    if (index >= 0) {
      for (String element in tempUser.supporting!) {
        supporting.add(_user[_indexOf(element)]);
      }
    }
    return supporting;
  }

  List<AppUser> get users => <AppUser>[..._user];

  AppUser user({required String uid}) {
    int index = _indexOf(uid);
    return _user[index];
  }

  void _fetchData(String uid) async {
    final AppUser? userInfo = await UserAPI().getInfo(uid: uid);
    _user.add(userInfo!);
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
