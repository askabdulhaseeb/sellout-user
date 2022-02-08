import 'package:shared_preferences/shared_preferences.dart';
import '../database/auth_methods.dart';
import '../models/app_user.dart';

class UserLocalData {
  static late SharedPreferences? _preferences;
  static Future<void> init() async =>
      _preferences = await SharedPreferences.getInstance();

  static void signout() => _preferences!.clear();

  static const String _uidKey = 'UIDKEY';
  static const String _displayNameKey = 'DISPLAYNAMEKEY';
  static const String _usernameKey = 'USERNAMEKEY';
  static const String _imageURLKey = 'IMAGEURLKEY';
  static const String _emailKey = 'EMAILKEY';
  static const String _isVerifiedKey = 'ISVERIFIEDKEY';
  static const String _ratingKey = 'RATINGKEY';
  static const String _bioKey = 'BIOKEY';
  static const String _postsKey = 'POSTKEY';
  static const String _supportingKey = 'SUPPORTINGKEY';
  static const String _supportersKey = 'SUPPORTIERSKEY';

  //
  // Setters
  //
  static Future<void> setUID(String uid) async =>
      _preferences!.setString(_uidKey, uid);

  static Future<void> setDisplayName(String name) async =>
      _preferences!.setString(_displayNameKey, name);

  static Future<void> setUsername(String username) async =>
      _preferences!.setString(_usernameKey, username);

  static Future<void> setImageUrl(String url) async =>
      _preferences!.setString(_imageURLKey, url);

  static Future<void> setEmail(String email) async =>
      _preferences!.setString(_emailKey, email);

  static Future<void> setIsVerified(bool isVerified) async =>
      _preferences!.setBool(_isVerifiedKey, isVerified);

  static Future<void> setRating(double rating) async =>
      _preferences!.setDouble(_ratingKey, rating);

  static Future<void> setBio(String bio) async =>
      _preferences!.setString(_bioKey, bio);

  static Future<void> setPosts(List<String> post) async =>
      _preferences!.setStringList(_postsKey, post);

  static Future<void> setSupporters(List<String> supporters) async =>
      _preferences!.setStringList(_supportersKey, supporters);

  static Future<void> setSupporting(List<String> supporting) async =>
      _preferences!.setStringList(_supportingKey, supporting);

  //
  // Getters
  //
  static String get getUID => _preferences!.getString(_uidKey) ?? '';
  static String get getDisplayName =>
      _preferences!.getString(_displayNameKey) ?? '';
  static String get getUsername => _preferences!.getString(_usernameKey) ?? '';
  static String get getImageURL => _preferences!.getString(_imageURLKey) ?? '';
  static String get getEmail => _preferences!.getString(_emailKey) ?? '';
  static bool get getIsVarified =>
      _preferences!.getBool(_isVerifiedKey) ?? false;
  static double get getRating => _preferences!.getDouble(_ratingKey) ?? 0.0;
  static String get getBio => _preferences!.getString(_bioKey) ?? '';
  static List<String> get getPost =>
      _preferences!.getStringList(_postsKey) ?? <String>[];
  static List<String> get getSupporters =>
      _preferences!.getStringList(_supportersKey) ?? <String>[];
  static List<String> get getSupporting =>
      _preferences!.getStringList(_supportingKey) ?? <String>[];

  void storeAppUserData({required AppUser appUser}) {
    setUID(appUser.uid);
    setDisplayName(appUser.displayName ?? '');
    setUsername(appUser.username ?? '');
    setImageUrl(appUser.imageURL ?? '');
    setEmail(appUser.email ?? '');
    setIsVerified(appUser.isVerified ?? false);
    setRating(appUser.rating ?? 0.0);
    setBio(appUser.bio ?? '');
    setPosts(appUser.posts ?? <String>[]);
    setSupporters(appUser.supporters ?? <String>[]);
    setSupporting(appUser.supporting ?? <String>[]);
  }

  AppUser get user {
    return AppUser(
      uid: AuthMethods.uid,
      displayName: getDisplayName,
      username: getUsername,
      imageURL: getImageURL,
      email: getEmail,
      isVerified: getIsVarified,
      rating: getRating,
      posts: getPost,
      supporters: getSupporters,
      supporting: getSupporting,
    );
  }
}
