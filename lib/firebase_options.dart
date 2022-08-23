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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBlMxlea4GMyrSY7xgB7oX1e1AjfeQ9m4o',
    appId: '1:956747948081:web:2d313aca8718ee5487b510',
    messagingSenderId: '956747948081',
    projectId: 'smartstudy-aa5f6',
    authDomain: 'smartstudy-aa5f6.firebaseapp.com',
    storageBucket: 'smartstudy-aa5f6.appspot.com',
    measurementId: 'G-PDE24B4GHG',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyANcwJIXrax8TDMhvARBvpAEnVqeDbD_Oo',
    appId: '1:956747948081:android:75771a126037323f87b510',
    messagingSenderId: '956747948081',
    projectId: 'smartstudy-aa5f6',
    storageBucket: 'smartstudy-aa5f6.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDlYyu01c91Q3u4q4mTy08by9mBQkyMeyI',
    appId: '1:956747948081:ios:c31532284a34663187b510',
    messagingSenderId: '956747948081',
    projectId: 'smartstudy-aa5f6',
    storageBucket: 'smartstudy-aa5f6.appspot.com',
    iosClientId: '956747948081-dotn3loc40s84e8te1alnkpl5quvaf3c.apps.googleusercontent.com',
    iosBundleId: 'com.smartcare.smartCare',
  );
}
