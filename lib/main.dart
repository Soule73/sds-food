import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:sds_food/Screens/welcome/welcome.dart';
import 'package:get/get.dart';
import 'package:sds_food/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sds_food/themes/theme_controller.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

ThemeData _darkTheme = ThemeData(
    useMaterial3: true,

    // colorScheme: ColorScheme.fromSeed(seedColor: Colors.pinkAccent),
    brightness: Brightness.dark,
    primaryColor: Colors.white,
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.pink,
      disabledColor: Colors.grey,
    ));

ThemeData _lightTheme = ThemeData(
    useMaterial3: true,

    // hintColor: Colors.pink,
    brightness: Brightness.light,
    primaryColor: Colors.black,
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.pink,
      disabledColor: Colors.grey,
    )
    // colorScheme: ColorScheme.fromSeed(seedColor: Colors.pinkAccent),
    );
Future<void> main() async {
  await dotenv.load(fileName: ".env");

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final stripePublique = dotenv.env['STRIPE_PUBLIQUE'];

  Stripe.publishableKey = stripePublique!;
  runApp(
    SDSFoodApp(),
  );
}

class SDSFoodApp extends StatelessWidget {
  SDSFoodApp({super.key});

  final themeController = Get.put(ThemeController());
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   useMaterial3: true,
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.pinkAccent),
      // ),
      theme: _lightTheme,
      darkTheme: _darkTheme,

      // themeMode: Get.find<ThemeController>().isLightTheme.value
      themeMode: Get.find<ThemeController>().themeMode.value,
      // Définissez les routes ici
      // routes: {
      //   '/welcome': (context) => const WelcomeScreen(),
      //   '/home': (context) => HomeScreen(),
      //   '/sign_in': (context) => const SignInScreen(),
      //   '/sign_up': (context) => const SignUpScreen(),
      //   '/reset_password': (context) => const ResetPasswordScreen(),
      //   // Ajoutez d'autres routes au besoin
      // },
      // initialRoute: '/welcome', // La route initiale
      home: const WelcomeScreen(),
    );
  }
}
