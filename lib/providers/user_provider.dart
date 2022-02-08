import 'package:flutter/material.dart';

import '../models/app_user.dart';

class UserProvider extends ChangeNotifier {
  final List<AppUser?> _user = <AppUser?>[];
  void addUser(AppUser newUser) {
    _user.add(newUser);
  }

  AppUser? getUser({required String uid}) {
    return _user.firstWhere(
      (AppUser? user) => user!.uid == uid,
      orElse: () => null,
    );
  }
}
