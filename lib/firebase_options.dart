// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
///
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
    apiKey: 'AIzaSyDh6_MSLUREYkaZzEJPd9WbHikdNGaPgX8',
    appId: '1:509519047545:web:ba6778a16bf87df06e5da8',
    messagingSenderId: '509519047545',
    projectId: 'milk-project-9fa51',
    authDomain: 'milk-project-9fa51.firebaseapp.com',
    storageBucket: 'milk-project-9fa51.firebasestorage.app',
    measurementId: 'G-FND3BZNNQ6',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAseYGO7uBWDePH9SJn68wXGL2F0BjNFt4',
    appId: '1:509519047545:android:9f08178509fcd43f6e5da8',
    messagingSenderId: '509519047545',
    projectId: 'milk-project-9fa51',
    storageBucket: 'milk-project-9fa51.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBARgnFUPjHM6yNJNwA2ryExWkbo5kRvFA',
    appId: '1:509519047545:ios:f227006b02f7669f6e5da8',
    messagingSenderId: '509519047545',
    projectId: 'milk-project-9fa51',
    storageBucket: 'milk-project-9fa51.firebasestorage.app',
    iosBundleId: 'com.example.milkproject',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBARgnFUPjHM6yNJNwA2ryExWkbo5kRvFA',
    appId: '1:509519047545:ios:f227006b02f7669f6e5da8',
    messagingSenderId: '509519047545',
    projectId: 'milk-project-9fa51',
    storageBucket: 'milk-project-9fa51.firebasestorage.app',
    iosBundleId: 'com.example.milkproject',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDh6_MSLUREYkaZzEJPd9WbHikdNGaPgX8',
    appId: '1:509519047545:web:a249ba400aaab26d6e5da8',
    messagingSenderId: '509519047545',
    projectId: 'milk-project-9fa51',
    authDomain: 'milk-project-9fa51.firebaseapp.com',
    storageBucket: 'milk-project-9fa51.firebasestorage.app',
    measurementId: 'G-QG05J0E3YK',
  );
}
