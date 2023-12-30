// part of 'authentication_bloc.dart';

// Remplacez le bloc par un contrôleur Getx
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:sds_food/Screens/welcome/welcome.dart';
import 'package:sds_food/services/authentication.dart';

class AuthenticationController extends GetxController {
  final AuthService authService = AuthService();
  // Créez des variables réactives pour gérer l'état de l'authentification
  Rx<User?> user = Rx<User?>(null);
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  final Future<FirebaseApp> firebaseInitialization = Firebase.initializeApp();
  @override
  void onReady() {
    super.onReady();
    user = Rx<User?>(auth.currentUser);

    ever(user, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user != null) {
      // user is logged in
      Get.offAll(() => const WelcomeScreen());
    }
    // else {
    //   // user is null as in user is not available or not logged in
    //   Get.offAll(() => const SignInScreen());
    // }
  }

  // Créez des méthodes pour gérer les événements d'authentification
  Future<void> signUpUser(String email, String password) async {
    isLoading.value = true; // Mettez à jour l'état de chargement
    try {
      user.value = await authService.signUpUser(
          email, password); // Mettez à jour l'utilisateur
      if (user.value == null) {
        errorMessage.value =
            'create user failed'; // Mettez à jour le message d'erreur
      } else {
        Get.to(() => const WelcomeScreen());
      }
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
    isLoading.value = false; // Mettez à jour l'état de chargement
  }

  Future<void> signInUser(String email, String password) async {
    isLoading.value = true; // Mettez à jour l'état de chargement
    try {
      user.value = await authService.signInUser(
          email, password); // Mettez à jour l'utilisateur
      if (user.value == null) {
        errorMessage.value =
            'create user failed'; // Mettez à jour le message d'erreur
      } else {
        Get.to(() => const WelcomeScreen());
      }
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
    isLoading.value = false; // Mettez à jour l'état de chargement
  }

  Future<void> signOutUser() async {
    isLoading.value = true; // Mettez à jour l'état de chargement
    try {
      await authService.signOutUser();
      user.value = null; // Mettez à jour l'utilisateur
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
    isLoading.value = false; // Mettez à jour l'état de chargement
  }
}
