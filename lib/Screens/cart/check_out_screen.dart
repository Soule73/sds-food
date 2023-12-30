import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sds_food/components/scaffold_default.dart';
import 'package:get/get.dart';
import 'package:sds_food/constants.dart';

class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldDefault(
        leading: IconButton(
            icon: SvgPicture.asset('assets/icons/back.svg'),
            onPressed: () {
              Get.back();
            }),
        title: "Confirmé la commande",
        body: const SingleChildScrollView(
          padding: EdgeInsets.all(kDefaultPadding),
          child: Text("Confirmé la commande"),
        ));
  }
}
