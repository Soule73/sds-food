import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sds_food/components/scaffold_default.dart';
import 'package:sds_food/themes/theme_controller.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldDefault(
        title: 'Paramétre',
        leading: IconButton(
            icon: SvgPicture.asset('assets/icons/back.svg'),
            onPressed: () {
              Get.back();
            }),
        actions: const <Widget>[],
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                const Expanded(
                  flex: 5,
                  child: Text(
                    "Theme Sombre",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Obx(() => Switch(
                      // This bool value toggles the switch.
                      value: Get.find<ThemeController>().themeMode.value ==
                          ThemeMode.dark,
                      activeColor: Colors.red,
                      onChanged: (bool value) {
                        Get.find<ThemeController>().toggleTheme();
                      })),
                )
              ],
            )));
  }
}
