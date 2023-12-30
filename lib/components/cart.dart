import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sds_food/Screens/cart/cart_out_screen.dart';
import 'package:sds_food/controllers/checkout_controller.dart';
import 'package:badges/badges.dart' as badge;

class Cart extends StatelessWidget {
  Cart({super.key});
  final CheckOutController checkOutController = Get.put(CheckOutController());

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => Get.to(CartOutScreen()),
        icon: badge.Badge(
          badgeContent: Obx(() => Text(
                '${checkOutController.itemInCartCount}',
                style: const TextStyle(color: Colors.white),
              )),
          child: const FaIcon(
            FontAwesomeIcons.bagShopping,
            color: Colors.white,
          ),
        ));
  }
}
