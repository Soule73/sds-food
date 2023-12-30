import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:sds_food/controllers/auth_status_controller.dart';
import 'package:sds_food/controllers/profile_controller.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  /// create user
  Future<User?> signUpUser(
    String email,
    String password,
  ) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      final User? firebaseUser = userCredential.user;
      if (firebaseUser != null) {
        return firebaseUser;
      }
    } on FirebaseAuthException catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
    return null;
  }

  Future<User?> signInUser(String email, String password) async {
    ProfileController profileController = Get.put(ProfileController());

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      final User? firebaseUser = userCredential.user;
      if (firebaseUser != null) {
        profileController.getUser();

        return firebaseUser;
      }
    } on FirebaseAuthException catch (e) {
      // ignore: avoid_print
      print('Error: ${e.message}');
    }
    return null;
  }

  ///signOutUser
  Future<void> signOutUser() async {
    ProfileController profileController = Get.put(ProfileController());
    final User? firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await FirebaseAuth.instance.signOut();
    }
    profileController.setImageUrl("");
  }

  Future<AuthStatus> resetUserPassword({required String email}) async {
    final auth = FirebaseAuth.instance;
    dynamic status;
    await auth
        .sendPasswordResetEmail(email: email)
        .then((value) => status = AuthStatus.successful)
        .catchError(
            (e) => status = AuthExceptionHandler.handleAuthException(e));
    return status;
  }
  // ... (other methods)}
}
