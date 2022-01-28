import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomService {
  static void statusBar() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color(0xFFD32F2F),
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Color(0xFFD32F2F),
        systemStatusBarContrastEnforced: false,
      ),
    );
  }

  static SystemUiOverlayStyle systemUIOverlayStyle() {
    return const SystemUiOverlayStyle(
      statusBarColor: Color(0xFFD32F2F),
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xFFD32F2F),
      systemStatusBarContrastEnforced: false,
    );
  }

  static void dismissKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  
}
