import 'package:flutter/material.dart';
import '../enums/screen_state_enum.dart';

class AuthStateProvider extends ChangeNotifier {
  // ignore: prefer_final_fields
  ScreenStateEnum _state = ScreenStateEnum.DONE;
  ScreenStateEnum get currentState => _state;

  // Update State
  void updateState(ScreenStateEnum state) {
    _state = state;
    notifyListeners();
  }

  void resetState() {
    _state = ScreenStateEnum.DONE;
    notifyListeners();
  }
}
