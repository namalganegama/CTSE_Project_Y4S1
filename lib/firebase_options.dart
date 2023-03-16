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
    apiKey: 'AIzaSyDircQqF3b_xIw5UtXJK-NLnri2uFVjOX4',
    appId: '1:684143871341:web:638a52b6d4ca2be7770664',
    messagingSenderId: '684143871341',
    projectId: 'charity-app-cb8f1',
    authDomain: 'charity-app-cb8f1.firebaseapp.com',
    storageBucket: 'charity-app-cb8f1.appspot.com',
    measurementId: 'G-LMCT0MCKTN',
    databaseURL: "https://charity-app-cb8f1-default-rtdb.firebaseio.com/",
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAzuGbDM7JD8UvaTB55LZz1dQqg-4k9_MY',
    appId: '1:684143871341:android:f0e7d1f729edb667770664',
    messagingSenderId: '684143871341',
    projectId: 'charity-app-cb8f1',
    storageBucket: 'charity-app-cb8f1.appspot.com',
    databaseURL: "https://charity-app-cb8f1-default-rtdb.firebaseio.com/",
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC_hRZwmdvciZn1ERIFiDliZrJ0b2cRYeM',
    appId: '1:684143871341:ios:eef2c27817e1535f770664',
    messagingSenderId: '684143871341',
    projectId: 'charity-app-cb8f1',
    storageBucket: 'charity-app-cb8f1.appspot.com',
    iosClientId:
        '684143871341-922vmsdvbqoa79s62efncam2lf5ia3di.apps.googleusercontent.com',
    iosBundleId: 'com.example.project',
    databaseURL: "https://charity-app-cb8f1-default-rtdb.firebaseio.com/",
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC_hRZwmdvciZn1ERIFiDliZrJ0b2cRYeM',
    appId: '1:684143871341:ios:eef2c27817e1535f770664',
    messagingSenderId: '684143871341',
    projectId: 'charity-app-cb8f1',
    storageBucket: 'charity-app-cb8f1.appspot.com',
    iosClientId:
        '684143871341-922vmsdvbqoa79s62efncam2lf5ia3di.apps.googleusercontent.com',
    iosBundleId: 'com.example.project',
    databaseURL: "https://charity-app-cb8f1-default-rtdb.firebaseio.com/",
  );
}