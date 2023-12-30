import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sds_food/Screens/auth/sign_in.dart';
import 'package:sds_food/Screens/welcome/welcome.dart';
import 'package:sds_food/header_section.dart';
import 'package:sds_food/layouts/auth_layout.dart';
import 'package:sds_food/services/authentication.dart';
import 'package:sds_food/widgets/input_email_widget.dart';
import 'package:sds_food/widgets/submit_btn_widget.dart';

class ResetPasswordController extends GetxController {
  final TextEditingController emailController = TextEditingController();

  RxBool send = false.obs;

  setSend() => send.value = true;

  final AuthService authService = AuthService();

  void resetPassword() {
    authService.resetUserPassword(email: emailController.text).then((value) {
      setSend();

      Get.snackbar(
        "Succès", // Ajoutez un titre
        "Nous avons envoyé un lien de réinitialisation à votre adresse",
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 8),
        backgroundColor: Colors.green,
        icon: const Icon(Icons.check, color: Colors.grey), // Ajoutez une icône
        mainButton: TextButton(
            onPressed: () {}, child: const Text("OK")), // Ajoutez un bouton
      );
      Get.reset(); // Utilisez Get.reset au lieu de emailController.text = "";
    }).catchError((onError) {
      Get.snackbar(
        "Oups Erreur !", // Ajoutez un titre
        "Quelque chose c'est mal passé. Merci d'essayer plus tard",
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 8),
        backgroundColor: Colors.red,
        colorText: Colors.grey[100]!,
        icon: const Icon(Icons.error, color: Colors.grey), // Ajoutez une icône
        mainButton: TextButton(
            onPressed: () {}, child: const Text("OK")), // Ajoutez un bouton
      );
      Get.reset(); // Utilisez Get.reset au lieu de emailController.text = "";
    });
  }
}

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
        child: Padding(
      padding: const EdgeInsets.fromLTRB(8, 10, 8, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const HeaderSection(
            title: "Reset Password",
            subTitle:
                "Si vous avez oublié votre mot de passe, ne vous inquiétez pas. Donnez-nous simplement votre adresse e-mail et nous vous enverrons par e-mail un lien pour réinitialisez votre mot de passe.",
          ),
          CustomForm(),
        ],
      ),
    ));
  }
}

class CustomForm extends StatelessWidget {
  final ResetPasswordController _resetPasswordController =
      Get.put(ResetPasswordController());

  CustomForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Column(
            children: [
              InputEmailWidget(
                  placeHolder: 'Email',
                  controller: _resetPasswordController.emailController),
              const SizedBox(
                height: 20,
              ),
              Obx(() => _resetPasswordController.send.value
                  ? SubmitBtnWidget(
                      title: 'Aller à l\'acceuille',
                      onPress: () => Get.off(const WelcomeScreen()),
                    )
                  : SubmitBtnWidget(
                      title: 'Réinitialisez',
                      onPress: () => _resetPasswordController.resetPassword(),
                    )),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Souvenez-vous de votre mot de passe?",
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(width: 5),
                    InkWell(
                        onTap: () {
                          Get.to(() => const SignInScreen());
                        },
                        child: const Text(
                          "Se connecter",
                          style: TextStyle(
                              color: Colors.pink, fontWeight: FontWeight.w500),
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
