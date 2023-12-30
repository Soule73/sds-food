import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sds_food/Screens/auth/reset_password.dart';
import 'package:sds_food/Screens/auth/sign_up.dart';
import 'package:sds_food/controllers/authentification_controller.dart';
import 'package:sds_food/header_section.dart';
import 'package:sds_food/layouts/auth_layout.dart';
import 'package:sds_food/widgets/input_email_widget.dart';
import 'package:sds_food/widgets/input_password.dart';
import 'package:sds_food/widgets/other_login_method_section.dart';
import 'package:sds_food/widgets/submit_btn_widget.dart';

class SignInController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  AuthenticationController authenticationController =
      Get.put(AuthenticationController());
  void signInScreen() {
    authenticationController.signInUser(
        emailController.text, passwordController.text);
  }
}

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
        child: Padding(
      padding: const EdgeInsets.fromLTRB(8, 10, 8, 0),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const HeaderSection(
            title: "Connexion",
            subTitle: "Veuillez vous connecter pour utiliser notre application",
          ),
          CustomForm(),
          const OtherLoginMethod()
        ],
      ),
    ));
  }
}

class CustomForm extends StatelessWidget {
  CustomForm({super.key});

  final SignInController _signInController = Get.put(SignInController());
  final AuthenticationController _authenticationController =
      Get.put(AuthenticationController());
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
                  placeHolder: 'E-mail',
                  controller: _signInController.emailController),
              InputPasswordWidget(
                placeHolder: 'Mot de passe',
                controller: _signInController.passwordController,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(() => const ResetPasswordScreen());
                      },
                      child: const Text(
                        "Mot de passe oublié?",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(() => SubmitBtnWidget(
                  title: _authenticationController.isLoading.value
                      ? "En cours..."
                      : "S'inscrire",
                  onPress: () => _signInController.signInScreen(),
                  loading: _authenticationController.isLoading.value
                      ? Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: SizedBox(
                            height: 25.0,
                            width: 25.0,
                            child: Center(
                                child: CircularProgressIndicator(
                              color: Theme.of(context).primaryColor,
                            )),
                          ),
                        )
                      : Container())),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Vous n'avez pas de compte ?",
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(width: 5),
                    InkWell(
                        onTap: () {
                          Get.to(() => const SignUpScreen());
                        },
                        child: const Text(
                          "S'inscrire",
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
