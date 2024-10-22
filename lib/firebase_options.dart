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
    apiKey: 'AIzaSyAWYCDFPTtB22QnTQ_blBJdI0FhK5WIauM',
    appId: '1:34833464571:web:2f5cf3ba45a4aec4c0445e',
    messagingSenderId: '34833464571',
    projectId: 'janbahon-4e06f',
    authDomain: 'janbahon-4e06f.firebaseapp.com',
    storageBucket: 'janbahon-4e06f.appspot.com',
    measurementId: 'G-F194EWY1KG',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA5wYpHnwOIg0JPE23aUhrdAnZmj8tORnM',
    appId: '1:34833464571:android:3ccedff3800a534cc0445e',
    messagingSenderId: '34833464571',
    projectId: 'janbahon-4e06f',
    storageBucket: 'janbahon-4e06f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB_2GQ_cYRUzGgY-1hg_3Eyr99ePvo9-9Y',
    appId: '1:34833464571:ios:ca49a07be580a1ccc0445e',
    messagingSenderId: '34833464571',
    projectId: 'janbahon-4e06f',
    storageBucket: 'janbahon-4e06f.appspot.com',
    iosBundleId: 'com.example.janBahon',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB_2GQ_cYRUzGgY-1hg_3Eyr99ePvo9-9Y',
    appId: '1:34833464571:ios:ca49a07be580a1ccc0445e',
    messagingSenderId: '34833464571',
    projectId: 'janbahon-4e06f',
    storageBucket: 'janbahon-4e06f.appspot.com',
    iosBundleId: 'com.example.janBahon',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAWYCDFPTtB22QnTQ_blBJdI0FhK5WIauM',
    appId: '1:34833464571:web:02178eb1f5d774b5c0445e',
    messagingSenderId: '34833464571',
    projectId: 'janbahon-4e06f',
    authDomain: 'janbahon-4e06f.firebaseapp.com',
    storageBucket: 'janbahon-4e06f.appspot.com',
    measurementId: 'G-WLX9G6CC0R',
  );
}
