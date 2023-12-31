// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCyL_a_HXE6NmRLwJqNa6g4sGSOOdpq3cQ',
    appId: '1:267979974031:web:377b50facd2f17ca42d7fa',
    messagingSenderId: '267979974031',
    projectId: 'sds-food-d4c3b',
    authDomain: 'sds-food-d4c3b.firebaseapp.com',
    storageBucket: 'sds-food-d4c3b.appspot.com',
    measurementId: 'G-7R0VCZR68G',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDnPzwylp_s4NGsr8J8GSN9GzUPm85vjYY',
    appId: '1:267979974031:android:8e02ce759c12aa0742d7fa',
    messagingSenderId: '267979974031',
    projectId: 'sds-food-d4c3b',
    storageBucket: 'sds-food-d4c3b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBE65vjWmdVlYJ77QFAga_NHgxIvAkiSBM',
    appId: '1:267979974031:ios:bb690968699d815942d7fa',
    messagingSenderId: '267979974031',
    projectId: 'sds-food-d4c3b',
    storageBucket: 'sds-food-d4c3b.appspot.com',
    iosBundleId: 'com.sds.sdsfood',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBE65vjWmdVlYJ77QFAga_NHgxIvAkiSBM',
    appId: '1:267979974031:ios:76d965b67c0a67fb42d7fa',
    messagingSenderId: '267979974031',
    projectId: 'sds-food-d4c3b',
    storageBucket: 'sds-food-d4c3b.appspot.com',
    iosBundleId: 'com.example.smartFormationProjet.RunnerTests',
  );
}
