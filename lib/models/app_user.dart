import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/custom_widgets/gender_selection_button.dart';

class AppUser {
  AppUser({
    required this.uid,
    this.displayName = '',
    this.username = '',
    this.gender = GenderTypes.MALE,
    this.dob = '',
    this.countryCode = '',
    this.phoneNumber = '',
    this.email = '',
    this.isPublicProfile = true,
    this.imageURL = '',
    this.isBlock = false,
    this.isVerified = false,
    this.rating = 0.0,
    this.bio = '',
    this.posts,
    this.supporting,
    this.supporters,
  });

  final String uid;
  final String? displayName;
  final String? username;
  final String? imageURL;
  final GenderTypes? gender;
  final String? dob;
  final String? countryCode;
  final String? phoneNumber;
  final String? email;
  final bool? isPublicProfile;
  final bool? isBlock;
  final bool? isVerified;
  final double? rating;
  final String? bio;
  final List<String>? posts;
  final List<String>? supporting;
  final List<String>? supporters;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'displayName': displayName ?? '',
      'username': username ?? '',
      'imageURL': imageURL ?? '',
      'gender': GenderConverter.genderToString(gender ?? GenderTypes.MALE),
      'dob': dob ?? '',
      'countryCode': countryCode ?? '',
      'phoneNumber': phoneNumber ?? '',
      'email': email ?? '',
      'isPublicProfile': isPublicProfile ?? true,
      'isBlock': isBlock ?? false,
      'isVerified': isVerified ?? false,
      'rating': rating ?? 0,
      'bio': bio ?? '',
      'posts': posts ?? <String>[],
      'supporting': supporting ?? <String>[],
      'supporters': supporters ?? <String>[],
    };
  }

  Map<String, dynamic> updateProfile() {
    return <String, dynamic>{
      'displayName': displayName ?? '',
      'username': username ?? '',
      'imageURL': imageURL ?? '',
      // 'countryCode': countryCode ?? '',
      // 'phoneNumber': phoneNumber ?? '',
      'isPublicProfile': isPublicProfile ?? true,
      'bio': bio ?? '',
    };
  }

  Map<String, dynamic> updateSupport() {
    return <String, dynamic>{
      'supporting': supporting ?? <String>[],
      'supporters': supporters ?? <String>[],
    };
  }

  // ignore: sort_constructors_first
  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      uid: map['uid'] ?? '',
      displayName: map['displayName'] ?? '',
      username: map['username'] ?? '',
      imageURL: map['imageURL'],
      email: map['email'] ?? '',
      rating: double.parse(map['rating']),
      countryCode: '',
      dob: '',
      gender: GenderConverter.stringToGender(map['gender']),
      phoneNumber: '',
    );
  }
  // ignore: sort_constructors_first
  factory AppUser.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    return AppUser(
      uid: doc.data()!['uid'] ?? '',
      displayName: doc.data()!['displayName'] ?? '',
      username: doc.data()!['username'] ?? '',
      imageURL: doc.data()!['imageURL'],
      gender: GenderConverter.stringToGender(doc.data()!['gender']),
      dob: doc.data()!['dob'] ?? '',
      countryCode: doc.data()!['countryCode'] ?? '',
      phoneNumber: doc.data()!['phoneNumber'] ?? '',
      email: doc.data()!['email'] ?? '',
      isPublicProfile: doc.data()!['isPublicProfile'] ?? false,
      isBlock: doc.data()!['isBlock'],
      rating: doc.data()!['rating']?.toDouble(),
      bio: doc.data()!['bio'],
      posts: List<String>.from(doc.data()!['posts']),
      supporting: List<String>.from(doc.data()!['supporting']),
      supporters: List<String>.from(doc.data()!['supporters']),
    );
  }
}
