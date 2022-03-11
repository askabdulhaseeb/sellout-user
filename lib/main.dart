import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/user_provider.dart';
import 'providers/auth_state_provider.dart';
import 'providers/main_bottom_nav_bar_provider.dart';
import 'providers/message_page_provider.dart';
import 'providers/prod_provider.dart';
import 'providers/product_category_provider.dart';
import 'screens/auth/auth_type_screen.dart';
import 'screens/auth/forget_password_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/edit_profile/edit_profile_screen.dart';
import 'screens/bit_screen/bit_screen.dart';
import 'screens/main_screen/main_screen.dart';
import 'screens/message_screens/group/create_group_screen.dart';
import 'screens/message_screens/stories/add_media_story_screen.dart';
import 'services/custom_services.dart';
import 'services/user_local_data.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await UserLocalData.init();
  CustomService.statusBar();
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
        ChangeNotifierProvider<AuthStateProvider>(
          create: (BuildContext context) => AuthStateProvider(),
        ),
        ChangeNotifierProvider<UserProvider>(
          create: (BuildContext context) => UserProvider(),
        ),
        ChangeNotifierProvider<AppProvider>(
          create: (BuildContext context) => AppProvider(),
        ),
        ChangeNotifierProvider<ProdProvider>(
          create: (BuildContext context) => ProdProvider(),
        ),
        ChangeNotifierProvider<ProdCatProvider>(
          create: (BuildContext context) => ProdCatProvider(),
        ),
        ChangeNotifierProvider<MessagePageProvider>(
          create: (BuildContext context) => MessagePageProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SellOut',
        theme: ThemeData(
          dividerTheme: const DividerThemeData(thickness: 0.5, space: 0),
          appBarTheme: AppBarTheme(
            systemOverlayStyle: CustomService.systemUIOverlayStyle(),
            centerTitle: false,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          primaryColor: _kPrimaryColor,
          colorScheme: const ColorScheme(
            primary: _kPrimaryColor,
            secondary: _kSecondaryColor,
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
          CreateChatGroupScreen.routeName: (_) => const CreateChatGroupScreen(),
          EditProfileScreen.routeName: (_) => const EditProfileScreen(),
          AddMediaStoryScreen.routeName: (_) => const AddMediaStoryScreen(),
          // Bit Screen
          BitScreen.routeName: (_) => const BitScreen(),
        },
      ),
    );
  }
}

// Certificate fingerprints:
//   SHA1: F6:3C:6E:07:37:98:D1:37:8D:8D:AD:2B:80:BE:5E:2C:50:EF:71:F9
//   SHA256: B8:1F:B2:FF:CB:2E:A2:45:12:1B:22:43:35:C5:B6:CC:A5:3B:CE:D4:6B:97:93:EF:76:D9:81:0F:F9:16:4C:6E