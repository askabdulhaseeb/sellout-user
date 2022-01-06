import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/app_user.dart';
import '../services/user_local_data.dart';
import '../widgets/custom_toast.dart';

class UserAPI {
  static const String _collection = 'users';
  static final FirebaseFirestore _instance = FirebaseFirestore.instance;
  // functions
  Future<AppUser> getInfo({required String uid}) async {
    final DocumentSnapshot<Map<String, dynamic>> doc =
        await _instance.collection(_collection).doc(uid).get();
    return AppUser.fromDoc(doc);
  }

  Future<bool> addUser(AppUser appUser) async {
    await _instance
        .collection(_collection)
        .doc(appUser.uid)
        .set(appUser.toMap())
        .catchError((Object e) {
      CustomToast.errorToast(message: e.toString());
      // ignore: invalid_return_type_for_catch_error
      return false;
    });
    return true;
  }

  Future<void> followOrUnfollow(AppUser otherUser) async {
    // List<String> otherFollowers = otherUser.followers!;
    // List<String> currentUserFollowings = UserLocalData.getFollowings;
    // if (otherUser.followers!.contains(UserLocalData.getUID)) {
    //   // unfollow
    //   otherFollowers.remove(UserLocalData.getUID);
    //   currentUserFollowings.remove(otherUser.uid);
    //   List<String> _temp = UserLocalData.getFollowings;
    //   _temp.remove(otherUser.uid);
    //   UserLocalData.setFollowings(_temp);
    // } else {
    //   // follow
    //   otherFollowers.add(UserLocalData.getUID);
    //   currentUserFollowings.add(otherUser.uid);
    //   List<String> _temp = UserLocalData.getFollowings;
    //   _temp.add(otherUser.uid);
    //   UserLocalData.setFollowings(_temp);
    // }
    // // ignore: always_specify_types
    // Future.wait([
    //   _instance
    //       .collection(_collection)
    //       .doc(otherUser.uid)
    //       .update(<String, dynamic>{'followers': otherFollowers}),
    //   _instance
    //       .collection(_collection)
    //       .doc(UserLocalData.getUID)
    //       .update(<String, dynamic>{'followings': currentUserFollowings}),
    // ]);
  }

  Future<String> uploadImage(Uint8List? imageBytes, String uid) async {
    TaskSnapshot snapshot = await FirebaseStorage.instance
        .ref()
        .child('profile_images/$uid')
        .putData(imageBytes!);
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
      if (appUser.displayName.contains(name)) {
        users.add(appUser);
      }
    }
    return users;
  }

  Future<void> addpostcount(String digilogId) async {
    List<String> posts = UserLocalData.getPost;
    posts.add(digilogId);
    await _instance
        .collection(_collection)
        .doc(UserLocalData.getUID)
        .update(<String, dynamic>{'posts': posts});
  }
}
