import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sds_food/Screens/auth/sign_in.dart';
import 'package:sds_food/controllers/authentification_controller.dart';
import 'package:sds_food/header_section.dart';
import 'package:sds_food/layouts/auth_layout.dart';
import 'package:sds_food/widgets/input_email_widget.dart';
import 'package:sds_food/widgets/input_password.dart';
import 'package:sds_food/widgets/other_login_method_section.dart';
import 'package:sds_food/widgets/submit_btn_widget.dart';

class SignUpController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  AuthenticationController authenticationController =
      Get.put(AuthenticationController());

  void signUp() {
    if (passwordController.text == confirmPasswordController.text) {
      authenticationController.signUpUser(
          emailController.text, passwordController.text);
    } else {
      Get.snackbar(
        "Error",
        "Passwor not egal",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    // print(emailController.text +
    //     " " +
    //     passwordController.text +
    //     " " +
    //     confirmPasswordController.text);
  }
}

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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
            title: "S'inscrire maintenant",
            subTitle: "Créez un compte pour utiliser notre application",
          ),
          MyCustomForm(),
          const OtherLoginMethod()

          // const OtherLoginMethod()
        ],
      ),
    ));
  }
}

class MyCustomForm extends StatelessWidget {
  final SignUpController _signUpController = Get.put(SignUpController());
  MyCustomForm({
    super.key,
    // required this.setEmailValue,
  });

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
                  controller: _signUpController.emailController),
              InputPasswordWidget(
                placeHolder: 'Mot de passe',
                controller: _signUpController.passwordController,
              ),
              InputPasswordWidget(
                placeHolder: 'Confirmez le mot de passe',
                controller: _signUpController.confirmPasswordController,
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(() => SubmitBtnWidget(
                  title: _authenticationController.isLoading.value
                      ? "En cours..."
                      : "S'inscrire",
                  onPress: () => _signUpController.signUp(),
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
                      "Vous avez déjà un compte ?",
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
