import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellout/providers/product_category_provider.dart';
import 'package:sellout/screens/main_screen/main_screen.dart';
import 'providers/main_bottom_nav_bar_provider.dart';
import 'screens/auth/forget_password_screen.dart';
import 'screens/auth/auth_type_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'services/user_local_data.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await UserLocalData.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // const Color _kPrimaryColor = Color(0xFFC01719);
    const Color _kPrimaryColor = Color(0xFFD32F2F);
    const Color _kSecondaryColor = Color(0xFF7C4DFF);
    return MultiProvider(
      // ignore: always_specify_types
      providers: [
        ChangeNotifierProvider<MainBottomNavBarProvider>(
          create: (BuildContext context) => MainBottomNavBarProvider(),
        ),
        ChangeNotifierProvider<ProdCatProvider>(
          create: (BuildContext context) => ProdCatProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SellOut',
        theme: ThemeData(
          primaryColor: _kPrimaryColor,
          colorScheme: const ColorScheme(
            primary: _kPrimaryColor,
            primaryVariant: Colors.red,
            secondary: _kSecondaryColor,
            secondaryVariant: Colors.deepPurple,
            surface: Colors.white,
            background: Colors.white,
            error: Colors.red,
            onPrimary: Colors.red,
            onSecondary: Colors.deepPurple,
            onSurface: Colors.grey,
            onBackground: Colors.grey,
            onError: Colors.red,
            brightness: Brightness.light,
          ),
        ),
        home: UserLocalData.getUID.isEmpty
            ? const AuthTypeScreen()
            : const MainScreen(),
        routes: <String, WidgetBuilder>{
          AuthTypeScreen.routeName: (_) => const AuthTypeScreen(),
          LoginScreen.routeName: (_) => const LoginScreen(),
          ForgetPasswordScreen.routeName: (_) => const ForgetPasswordScreen(),
          RegisterScreen.routeName: (_) => const RegisterScreen(),
          MainScreen.rotueName: (_) => const MainScreen(),
        },
      ),
    );
  }
}
