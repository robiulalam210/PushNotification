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
    apiKey: 'AIzaSyD_sXranAItOj2Lto7s-ws8tK2_IImQYQg',
    appId: '1:316430220089:web:22ae40f18f4b2e19b306e8',
    messagingSenderId: '316430220089',
    projectId: 'firbasenotification-8485a',
    authDomain: 'firbasenotification-8485a.firebaseapp.com',
    storageBucket: 'firbasenotification-8485a.appspot.com',
    measurementId: 'G-1Z3JS2PNSD',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA0Yd0ilHxbDBSXn2VEIUAq15hnh4NkDpM',
    appId: '1:316430220089:android:2a029c1f913507abb306e8',
    messagingSenderId: '316430220089',
    projectId: 'firbasenotification-8485a',
    storageBucket: 'firbasenotification-8485a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDGN2me-1j8oPOPKXIMmQkc8DbKE1jYJo0',
    appId: '1:316430220089:ios:41e0d7fd0c4feb5db306e8',
    messagingSenderId: '316430220089',
    projectId: 'firbasenotification-8485a',
    storageBucket: 'firbasenotification-8485a.appspot.com',
    iosClientId: '316430220089-t7bcn7c641shv7lav6u067h40od7fj4i.apps.googleusercontent.com',
    iosBundleId: 'com.example.notificationPush',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDGN2me-1j8oPOPKXIMmQkc8DbKE1jYJo0',
    appId: '1:316430220089:ios:41e0d7fd0c4feb5db306e8',
    messagingSenderId: '316430220089',
    projectId: 'firbasenotification-8485a',
    storageBucket: 'firbasenotification-8485a.appspot.com',
    iosClientId: '316430220089-t7bcn7c641shv7lav6u067h40od7fj4i.apps.googleusercontent.com',
    iosBundleId: 'com.example.notificationPush',
  );
}
