import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  final RxBool isLightTheme = false.obs;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  // La propriété themeMode qui contient le thème actuel de l'application
  var themeMode = ThemeMode.system.obs;

  // Le constructeur qui lit la valeur du thème stockée sur le disque et met à jour le thème de l'application
  @override
  onInit() {
    super.onInit();
    // Obtenir une instance des préférences partagées
    SharedPreferences.getInstance().then((prefs) {
      // Lire la valeur du thème stockée sur le disque
      var storedThemeMode = prefs.getString('themeMode');
      // Si aucune valeur n'est trouvée, utiliser ThemeMode.system comme valeur par défaut
      if (storedThemeMode == null) {
        themeMode.value = ThemeMode.system;
      } else {
        // Sinon, utiliser la valeur trouvée comme thème
        themeMode.value =
            storedThemeMode == 'dark' ? ThemeMode.dark : ThemeMode.light;
      }
      // Mettre à jour le thème de l'application
      update();
    });
  }

  // La méthode toggleTheme qui inverse la valeur de themeMode entre ThemeMode.dark et ThemeMode.light
  void toggleTheme() async {
    // Obtenir une instance des préférences partagées
    var prefs = await SharedPreferences.getInstance();
    // Si le thème actuel est sombre, passer au thème clair
    if (themeMode.value == ThemeMode.dark) {
      // Enregistrer la nouvelle valeur du thème sur le disque
      prefs.setString('themeMode', 'light');
      // Changer la valeur de themeMode
      themeMode.value = ThemeMode.light;
    } else {
      // Sinon, passer au thème sombre
      // Enregistrer la nouvelle valeur du thème sur le disque
      prefs.setString('themeMode', 'dark');
      // Changer la valeur de themeMode
      themeMode.value = ThemeMode.dark;
    }
    Get.changeThemeMode(themeMode.value);
    // Mettre à jour le thème de l'application
    update();
  }

  saveThemeStatus() async {
    SharedPreferences pref = await _prefs;
    pref.setBool('theme', isLightTheme.value);
  }

  getThemeStatus() async {
    var isLight = _prefs.then((SharedPreferences prefs) {
      return prefs.getBool('theme') ?? true;
    }).obs;
    isLightTheme.value = (await isLight.value);
  }
}
