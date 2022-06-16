import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/story.dart';
import '../services/user_local_data.dart';
import '../widgets/custom_widgets/custom_toast.dart';
import 'auth_methods.dart';

class StoriesAPI {
  static const String _collection = 'stories';
  static final FirebaseFirestore _instance = FirebaseFirestore.instance;

  Future<bool> addStory({required Story story}) async {
    try {
      await _instance.collection(_collection).doc(story.sid).set(story.toMap());
      return true;
    } catch (e) {
      CustomToast.errorToast(message: e.toString());
      return false;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>? getStories() {
    try {
      if (UserLocalData.getSupporting.isEmpty) {
        return _instance
            .collection(_collection)
            .orderBy('timestamp', descending: true)
            .snapshots();
      } else {
        final List<String> tempSupporting = UserLocalData.getSupporting;
        tempSupporting.add(AuthMethods.uid);
        return _instance
            .collection(_collection)
            .where('uid', whereIn: tempSupporting)
            .orderBy('timestamp', descending: true)
            .snapshots();
      }
    } catch (e) {
      CustomToast.errorToast(message: 'Facing issue: ${e.toString()}');
      return null;
    }
  }

  Future<String?> uploadImage({required File file}) async {
    try {
      TaskSnapshot snapshot = await FirebaseStorage.instance
          .ref(
              'stories/${AuthMethods.uid}/${DateTime.now().microsecondsSinceEpoch}')
          .putFile(file);
      String url = await snapshot.ref.getDownloadURL();
      return url;
    } catch (e) {
      return null;
    }
  }
}
