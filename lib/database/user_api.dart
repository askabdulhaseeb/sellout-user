import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/app_user.dart';
import '../services/user_local_data.dart';
import '../widgets/custom_widgets/custom_toast.dart';

class UserAPI {
  static const String _collection = 'users';
  static final FirebaseFirestore _instance = FirebaseFirestore.instance;
  // functions
  Future<List<AppUser>> getAllUsers() async {
    final List<AppUser> appUser = <AppUser>[];
    final QuerySnapshot<Map<String, dynamic>> doc =
        await _instance.collection(_collection).get();

    for (DocumentSnapshot<Map<String, dynamic>> element in doc.docs) {
      appUser.add(AppUser.fromDoc(element));
    }
    return appUser;
  }

  // functions
  Future<AppUser?>? getInfo({required String uid}) async {
    final DocumentSnapshot<Map<String, dynamic>> doc =
        await _instance.collection(_collection).doc(uid).get();
    if (doc.data() == null) return null;
    return AppUser.fromDoc(doc);
  }

  Future<bool> addUser(AppUser appUser) async {
    try {
      await _instance
          .collection(_collection)
          .doc(appUser.uid)
          .set(appUser.toMap());
      return true;
    } catch (e) {
      CustomToast.errorToast(message: e.toString());
      return false;
    }
  }

  Future<void> updateSupporting({
    required AppUser me,
    required AppUser other,
  }) async {
    try {
      // ignore: always_specify_types
      Future.wait([
        _instance
            .collection(_collection)
            .doc(me.uid)
            .update(me.updateSupport()),
        _instance
            .collection(_collection)
            .doc(other.uid)
            .update(other.updateSupport()),
      ]);
    } catch (e) {
      CustomToast.errorToast(message: e.toString());
    }
  }

  Future<bool> updateProfile(AppUser appUser) async {
    try {
      await _instance
          .collection(_collection)
          .doc(appUser.uid)
          .update(appUser.updateProfile());
      UserLocalData.setBio(appUser.bio!);
      UserLocalData.setDisplayName(appUser.displayName!);
      UserLocalData.setUsername(appUser.username!);
      UserLocalData.setImageUrl(appUser.imageURL!);
      return true;
    } catch (e) {
      CustomToast.errorToast(message: e.toString());
      return false;
    }
  }

  Future<String> uploadImage(File file, String uid) async {
    TaskSnapshot snapshot =
        await FirebaseStorage.instance.ref('profile_images/$uid').putFile(file);
    String url = (await snapshot.ref.getDownloadURL()).toString();
    return url;
  }

  Future<List<AppUser>> getAllfirebaseusersbyName(String name) async {
    List<AppUser> users = <AppUser>[];
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection(_collection).get();

    List<DocumentSnapshot<Map<String, dynamic>>> docs = snapshot.docs;
    for (DocumentSnapshot<Map<String, dynamic>> doc in docs) {
      AppUser appUser = AppUser.fromDoc(doc);
      if (appUser.displayName!.contains(name)) {
        users.add(appUser);
      }
    }
    return users;
  }

  Future<void> updatePosts(String pid) async {
    List<String> posts = UserLocalData.getPost;
    posts.add(pid);
    UserLocalData.setPosts(posts);
    await _instance
        .collection(_collection)
        .doc(UserLocalData.getUID)
        .update(<String, dynamic>{'posts': posts});
  }
}
