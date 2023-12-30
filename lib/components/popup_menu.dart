import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sds_food/Screens/auth/sign_in.dart';
import 'package:sds_food/Screens/auth/sign_up.dart';
import 'package:sds_food/Screens/profile/profle.dart';
import 'package:sds_food/controllers/authentification_controller.dart';
import 'package:sds_food/controllers/profile_controller.dart';

class PopupMenu extends StatelessWidget {
  PopupMenu({super.key});

  static final AuthenticationController authenticationController =
      Get.put(AuthenticationController());

  // Créez une instance de FirebaseAuth
  static FirebaseAuth auth = FirebaseAuth.instance;
  // Obtenez l'utilisateur actuellement connecté
  static final User? user = auth.currentUser;

  final List<MenuItem> menuItemGeust = [
    MenuItem(2, 'Se connecter', 'assets/icons/log_in.svg', () {
      Get.to(() => const SignInScreen());
    }),
    MenuItem(3, "S'inscrire", 'assets/icons/user_plus.svg', () {
      Get.to(() => const SignUpScreen());
    }),
  ];
  final List<MenuItem> menuItemAuth = [
    MenuItem(1, 'Profile', 'assets/icons/user_circle.svg',
        () => Get.to(() => ProfleScreen())),
    MenuItem(2, 'Se déconnecter', 'assets/icons/log_out.svg',
        () => authenticationController.signOutUser()),
  ];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        // Obtenez l'utilisateur du flux
        User? userAuth = snapshot.data;
        // Retournez une liste de widgets MenuItem en fonction de l'utilisateur
        return Obx(() => PopupMenuButtonWidget(
            menuItem:
                authenticationController.user.value != null || userAuth != null
                    ? menuItemAuth
                    : menuItemGeust));
      },
    );
  }
}

class PopupMenuButtonWidget extends StatelessWidget {
  final List<MenuItem> menuItem;
  PopupMenuButtonWidget({super.key, required this.menuItem});

  final ProfileController _profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Obx(() => _profileController.imageUrl.value != ""
            ? Padding(
                padding: const EdgeInsets.all(8),
                child: CircleAvatar(
                  backgroundImage:
                      NetworkImage(_profileController.imageUrl.value),
                ),
              )
            : Image.asset(
                "assets/images/user.png",
                width: 50,
              )),
      ),
      onSelected: (value) {
        for (int i = 0; i < menuItem.length; i++) {
          if (menuItem[i].id == value) {
            menuItem[i].action();
          }
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        for (int i = 0; i < menuItem.length; i++)
          popupMenuItem(
              menuItem[i].id, menuItem[i].text, menuItem[i].assetName, context),
      ],
    );
  }

  PopupMenuItem<dynamic> popupMenuItem(
      int id, String text, String assetName, BuildContext context) {
    return PopupMenuItem(
      value: id,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: SvgPicture.asset(
              assetName,
              // ignore: deprecated_member_use
              color: Theme.of(context).primaryColor,
            ),
          ),
          Text(
            text,
            style: const TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }
}

class MenuItem {
  final int id;
  final String text;
  final String assetName;
  final Function action;

  MenuItem(this.id, this.text, this.assetName, this.action);
}
