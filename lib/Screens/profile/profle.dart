import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sds_food/Screens/welcome/welcome.dart';

import 'package:get/get.dart';
import 'package:sds_food/components/scaffold_default.dart';
import 'package:sds_food/controllers/authentification_controller.dart';
import 'package:sds_food/controllers/profile_controller.dart';
import 'package:sds_food/uploads/file_upload.dart';
// import 'package:sds_food/uploads/upload.dart';

class ProfleScreen extends StatelessWidget {
  final ProfileController _profileController = Get.put(ProfileController());
  final AuthenticationController authenticationController =
      Get.put(AuthenticationController());

  ProfleScreen({super.key}); // Ajoutez un point-virgule et le mot-clé this

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (authenticationController.user.value == null) {
        Get.off(const WelcomeScreen()); // Utilisez Get.off au lieu de Get.to
      } else {
        return ScaffoldDefault(
          // Ajoutez un mot-clé return
          leading: IconButton(
              icon: SvgPicture.asset('assets/icons/back.svg'),
              onPressed: () {
                Get.back(); // Utilisez Get.back au lieu de Get.back()
              }),
          title: 'Profile',
          bottomNameFalse: true,
          body: Stack(
            alignment: Alignment.topCenter,
            children: [
              Center(
                  child: Column(
                children: [
                  Obx(() => _profileController.isSetUserProfile.value
                      ? const SizedBox(
                          height: 150.0,
                          child: Stack(
                            children: <Widget>[
                              Center(
                                child: SizedBox(
                                  width: 120,
                                  height: 120,
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                              Center(child: Text("En cours")),
                            ],
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: SizedBox(
                            width: 150,
                            height: 150,
                            child: _profileController.imageUrl.value == ""
                                ? CircleAvatar(
                                    child: ClipOval(
                                        child: Image.asset(
                                      "assets/images/placeholder.png",
                                      fit: BoxFit.contain,
                                    )),
                                  )
                                : CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        _profileController.imageUrl.value),
                                  ),
                          ),
                        )),
                  const ProfilePage(),
                  Text(
                    authenticationController.user.value!.email ?? "",
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              )),
            ],
          ),
        );
      }
      // Ajoutez une instruction return ici pour éviter l'erreur
      return const CircularProgressIndicator();
    });
  }
}
