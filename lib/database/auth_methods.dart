import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../functions/time_date_functions.dart';
import '../models/app_user.dart';
import '../services/user_local_data.dart';
import '../widgets/custom_widgets/gender_selection_button.dart';
import '../widgets/custom_widgets/custom_toast.dart';
import 'user_api.dart';

class AuthMethods {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static User? get getCurrentUser => _auth.currentUser;

  static String get uid => _auth.currentUser?.uid ?? '';
  
  static String get uniqueID => uid + TimeDateFunctions.timestamp.toString();

  Future<bool> signinWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleAccount.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        try {
          final UserCredential authResult = await _auth.signInWithCredential(
            GoogleAuthProvider.credential(
              idToken: googleAuth.idToken,
              accessToken: googleAuth.accessToken,
            ),
          );
          final User user = authResult.user!;
          final AppUser? alreadySignin =
              await UserAPI().getInfo(uid: user.uid);
          if (alreadySignin == null) {
            final AppUser appUser = AppUser(
              uid: user.uid,
              displayName: user.displayName!,
              email: user.email!,
              imageURL: user.photoURL!,
              countryCode: '',
              phoneNumber: '',
              dob: '',
              gender: GenderTypes.NOTAVAIABLE,
              username: user.email!,
            );

            final bool isOkay = await UserAPI().addUser(appUser);
            if (isOkay) {
              UserLocalData().storeAppUserData(appUser: appUser);
            } else {
              return false;
            }
          } else {
            UserLocalData().storeAppUserData(appUser: alreadySignin);
          }
          return true;
        } catch (error) {
          CustomToast.errorToast(message: error.toString());
        }
      }
    }
    return false;
  }

  Future<User?>? signupWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential result = await _auth
          .createUserWithEmailAndPassword(
        email: email.toLowerCase().trim(),
        password: password.trim(),
      )
          .catchError((Object obj) {
        CustomToast.errorToast(message: obj.toString());
      });
      final User? user = result.user;
      assert(user != null);
      return user;
    } catch (signUpError) {
      CustomToast.errorToast(message: signUpError.toString());
      return null;
    }
  }

  Future<User?> loginWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential result = await _auth
          .signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      )
          .catchError((Object obj) {
        CustomToast.errorToast(message: obj.toString());
      });
      final User? user = result.user;
      final AppUser? appUser = await UserAPI().getInfo(uid: user!.uid);
      UserLocalData().storeAppUserData(appUser: appUser!);
      return user;
    } catch (signUpError) {
      CustomToast.errorToast(message: signUpError.toString());
      return null;
    }
  }

  Future<bool> forgetPassword(String email) async {
    try {
      _auth.sendPasswordResetEmail(email: email.trim());
      return true;
    } catch (error) {
      CustomToast.errorToast(message: error.toString());
    }
    return false;
  }

  Future<void> signOut() async {
    UserLocalData.signout();
    await _auth.signOut();
  }
}
