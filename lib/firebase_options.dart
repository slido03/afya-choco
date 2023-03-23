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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyB5d29piycNM8p9YVFx1l6q9FKv2xII9sQ',
    appId: '1:218015848296:web:06dc1767f98286c079e8dd',
    messagingSenderId: '218015848296',
    projectId: 'afya-139eb',
    authDomain: 'afya-139eb.firebaseapp.com',
    storageBucket: 'afya-139eb.appspot.com',
    measurementId: 'G-X4VKK0BJ91',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAUkNeW0QtuZRI-y8EBmujjX4G7ED2wOe4',
    appId: '1:218015848296:android:9e4141c3420d38a679e8dd',
    messagingSenderId: '218015848296',
    projectId: 'afya-139eb',
    storageBucket: 'afya-139eb.appspot.com',
  );
}
