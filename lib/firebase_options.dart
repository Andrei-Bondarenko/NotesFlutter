// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyCKBsVShz0fTBijxoW3RZIMTmxUlENssa0',
    appId: '1:271463732193:web:b6e328bfa03cc19b3278a0',
    messagingSenderId: '271463732193',
    projectId: 'dsvdsvdsv-f75bd',
    authDomain: 'dsvdsvdsv-f75bd.firebaseapp.com',
    storageBucket: 'dsvdsvdsv-f75bd.appspot.com',
    measurementId: 'G-0B165VY76E',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAoRuJx029khlFpq8yhemjZus0n1TVXjRs',
    appId: '1:271463732193:android:c0e6443e87a569e33278a0',
    messagingSenderId: '271463732193',
    projectId: 'dsvdsvdsv-f75bd',
    storageBucket: 'dsvdsvdsv-f75bd.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCOJ1j_WJs3xM0yvx1PswyCJIkpRXVNqCg',
    appId: '1:271463732193:ios:8bbcc4e705ebd6be3278a0',
    messagingSenderId: '271463732193',
    projectId: 'dsvdsvdsv-f75bd',
    storageBucket: 'dsvdsvdsv-f75bd.appspot.com',
    iosBundleId: 'com.example.notes',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCOJ1j_WJs3xM0yvx1PswyCJIkpRXVNqCg',
    appId: '1:271463732193:ios:8bbcc4e705ebd6be3278a0',
    messagingSenderId: '271463732193',
    projectId: 'dsvdsvdsv-f75bd',
    storageBucket: 'dsvdsvdsv-f75bd.appspot.com',
    iosBundleId: 'com.example.notes',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCKBsVShz0fTBijxoW3RZIMTmxUlENssa0',
    appId: '1:271463732193:web:59d775a30e3740213278a0',
    messagingSenderId: '271463732193',
    projectId: 'dsvdsvdsv-f75bd',
    authDomain: 'dsvdsvdsv-f75bd.firebaseapp.com',
    storageBucket: 'dsvdsvdsv-f75bd.appspot.com',
    measurementId: 'G-5ENCVWJCEH',
  );

}