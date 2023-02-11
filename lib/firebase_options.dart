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
    apiKey: 'AIzaSyDSIBHnUyoLJw8bV0xMDa6Q1Tfc2OkgNLc',
    appId: '1:78187064285:web:5111e3419c89f4025a6434',
    messagingSenderId: '78187064285',
    projectId: 'emart-68c7a',
    authDomain: 'emart-68c7a.firebaseapp.com',
    storageBucket: 'emart-68c7a.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDqBtLwxrLhUgKy1L0SNyMac1uA5HIUx5g',
    appId: '1:78187064285:android:5823b5fe61a9b8115a6434',
    messagingSenderId: '78187064285',
    projectId: 'emart-68c7a',
    storageBucket: 'emart-68c7a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCrxPtwBhzcQGV4z8rUnZwrkCPD8lBtnkM',
    appId: '1:78187064285:ios:416b213abb7fe3f85a6434',
    messagingSenderId: '78187064285',
    projectId: 'emart-68c7a',
    storageBucket: 'emart-68c7a.appspot.com',
    iosClientId: '78187064285-5rhfi3ir8i3mc4p70m67mord57c4q85c.apps.googleusercontent.com',
    iosBundleId: 'com.example.emart',
  );
}