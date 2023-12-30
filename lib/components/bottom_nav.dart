import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sds_food/Screens/cart/cart_out_screen.dart';
import 'package:sds_food/Screens/home/home.dart';
import 'package:sds_food/Screens/profile/profle.dart';

import '../constants.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.0,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.pink[100], borderRadius: BorderRadius.circular(25)),
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding * 1.5),
      margin: const EdgeInsets.all(kDefaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          NavItem(
            tap: () => Get.to(() => HomeScreen()),
            icon: FontAwesomeIcons.house,
            route: "/HomeScreen",
          ),
          NavItem(
            tap: () {},
            icon: FontAwesomeIcons.comment,
            route: "/CommentScreen",
          ),
          NavItem(
            tap: () => Get.to(() => CartOutScreen()),
            icon: FontAwesomeIcons.bagShopping,
            route: "/CartOutScreen",
          ),
          NavItem(
            tap: () => Get.to(ProfleScreen()),
            icon: FontAwesomeIcons.user,
            route: "/ProfleScreen",
          ),
        ],
      ),
    );
  }
}

class NavItem extends StatelessWidget {
  const NavItem(
      {super.key, required this.tap, required this.icon, required this.route});

  final GestureTapCallback tap;
  final IconData icon;
  final String route;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tap,
      child: FaIcon(
        icon,
        color: Get.currentRoute == route ? Colors.pink : Colors.black,
      ),
    );
  }
}
