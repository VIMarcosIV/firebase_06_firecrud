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
    apiKey: 'AIzaSyCij650lwpjdGYeAaRkxohhtSXuAj4XDFM',
    appId: '1:750878769032:web:8593067cc4d312663d443d',
    messagingSenderId: '750878769032',
    projectId: 'flutterfiredam23msm',
    authDomain: 'flutterfiredam23msm.firebaseapp.com',
    storageBucket: 'flutterfiredam23msm.appspot.com',
    measurementId: 'G-6KT326VV7R',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCFQoc-HsmV4YR7T2VHpO2fFXLogG2oDvE',
    appId: '1:750878769032:android:a1e8a403b2972deb3d443d',
    messagingSenderId: '750878769032',
    projectId: 'flutterfiredam23msm',
    storageBucket: 'flutterfiredam23msm.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBvEUwuJPlBzS2s-I6r-Kq7u7kRN6E-Mn0',
    appId: '1:750878769032:ios:95976bf42fda938a3d443d',
    messagingSenderId: '750878769032',
    projectId: 'flutterfiredam23msm',
    storageBucket: 'flutterfiredam23msm.appspot.com',
    iosClientId: '750878769032-728cplcd74j5mgi4ui0b2cni5mio55o5.apps.googleusercontent.com',
    iosBundleId: 'com.iesch.flutter06Firebasecrud',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBvEUwuJPlBzS2s-I6r-Kq7u7kRN6E-Mn0',
    appId: '1:750878769032:ios:95976bf42fda938a3d443d',
    messagingSenderId: '750878769032',
    projectId: 'flutterfiredam23msm',
    storageBucket: 'flutterfiredam23msm.appspot.com',
    iosClientId: '750878769032-728cplcd74j5mgi4ui0b2cni5mio55o5.apps.googleusercontent.com',
    iosBundleId: 'com.iesch.flutter06Firebasecrud',
  );
}
