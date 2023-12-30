import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sds_food/Screens/auth/sign_in.dart';
import 'package:sds_food/Screens/auth/sign_up.dart';
import 'package:sds_food/Screens/home/home.dart';
import 'package:sds_food/Screens/profile/profle.dart';
import 'package:sds_food/Screens/setting/setting_screen.dart';
import 'package:sds_food/controllers/authentification_controller.dart';
import 'package:sds_food/controllers/profile_controller.dart';

class DrawerController extends GetxController {
  RxInt selectedIndex = 0.obs;

  void onItemTapped(int index) => selectedIndex.value = index;
}

class AppDrawer extends StatelessWidget {
  AppDrawer({super.key});

  static final AuthenticationController authenticationController =
      Get.put(AuthenticationController());
  final DrawerController drawerController = Get.put(DrawerController());

  static final List<MenuItem> other = [
    MenuItem("/HomeScreen", 'Menu', 'assets/icons/home.svg',
        () => Get.to(() => HomeScreen())),
    MenuItem("/SettingScreen", 'Paramétre', 'assets/icons/cog.svg',
        () => Get.to(() => const SettingScreen())),
  ];
  final List<MenuItem> drawerItemGeust = [
    other[0],
    MenuItem("/SignInScreen", 'Se connecter', 'assets/icons/log_in.svg', () {
      Get.to(() => const SignInScreen());
    }),
    MenuItem("/SignUpScreen", "S'inscrire", 'assets/icons/user_plus.svg', () {
      Get.to(() => const SignUpScreen());
    }),
    other[1],
  ];
  final List<MenuItem> drawerItemAuth = [
    other[0],
    MenuItem("/ProfleScreen", 'Profile', 'assets/icons/user_circle.svg',
        () => Get.to(() => ProfleScreen())),
    MenuItem("/SignOut", 'Se déconnecter', 'assets/icons/log_out.svg',
        () => authenticationController.signOutUser()),
    other[1],
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Obx(() => DrawerListItem(
              drawerItem: authenticationController.user.value != null
                  // || userAuth != null
                  ? drawerItemAuth
                  : drawerItemGeust,
            )));
  }
}

class DrawerListItem extends StatelessWidget {
  final List<MenuItem> drawerItem;
  final DrawerController drawerController = Get.put(DrawerController());
  final ProfileController _profileController = Get.put(ProfileController());

  DrawerListItem({super.key, required this.drawerItem});

  @override
  Widget build(BuildContext context) {
    return ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: const BoxDecoration(
            color: Colors.pink,
          ),
          child: Center(
              child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: SizedBox(
                width: 150,
                height: 150,
                child: Obx(
                  () => _profileController.imageUrl.value == ""
                      ? CircleAvatar(
                          child: ClipOval(
                              child: Image.asset(
                            "assets/images/placeholder.png",
                            fit: BoxFit.contain,
                          )),
                        )
                      : CircleAvatar(
                          backgroundImage:
                              NetworkImage(_profileController.imageUrl.value),
                        ),
                )),
          )),
        ),
        Transform.translate(
          offset: const Offset(
              0, -10), // Décale le widget de 10 pixels vers le haut
          child: Container(
            width: double.infinity, // Prend toute la largeur
            height: 80,
            alignment: Alignment.topCenter, // Aligné en haut
            child: SvgPicture.asset(
              "assets/icons/wave.svg",
              fit: BoxFit
                  .cover, // Remplit la largeur tout en conservant les proportions
            ),
          ),
        ),
        for (int i = 0; i < drawerItem.length; i++)
          DrawerItem(
            isSelected: Get.currentRoute == drawerItem[i].id,
            onTap: () {
              drawerItem[i].action();
              // drawerController.onItemTapped(drawerItem[i].id);
            },
            title: drawerItem[i].text,
            assetName: drawerItem[i].assetName,
          ),
      ],
    );
  }
}

class DrawerItem extends StatelessWidget {
  final bool isSelected;
  final String title;
  final Function onTap;
  final String assetName;
  const DrawerItem(
      {super.key,
      required this.isSelected,
      required this.onTap,
      required this.title,
      required this.assetName});

  @override
  Widget build(BuildContext context) {
    return Ink(
      color: isSelected ? Colors.pink : null,
      child: ListTile(
        leading: SvgPicture.asset(
          assetName,
          // ignore: deprecated_member_use
          color: isSelected ? Colors.white : Theme.of(context).primaryColor,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Theme.of(context).primaryColor,
          ),
        ),
        selected: isSelected,
        onTap: () => onTap(),
      ),
    );
  }
}

class MenuItem {
  final String id;
  final String text;
  final String assetName;
  final Function action;

  MenuItem(this.id, this.text, this.assetName, this.action);
}
