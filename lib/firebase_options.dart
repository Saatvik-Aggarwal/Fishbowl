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
    apiKey: 'AIzaSyBy5A5kEdilCaY5zQPefOGLQ1AqKLBLvQs',
    appId: '1:75060213403:web:4800055789aa326805783e',
    messagingSenderId: '75060213403',
    projectId: 'fishbowl-b1cf4',
    authDomain: 'fishbowl-b1cf4.firebaseapp.com',
    storageBucket: 'fishbowl-b1cf4.appspot.com',
    measurementId: 'G-L2T8VDGXE0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBtKVoif1rZT_kh07HWaN3BFaEB6imZJq8',
    appId: '1:75060213403:android:82d4b9415165137505783e',
    messagingSenderId: '75060213403',
    projectId: 'fishbowl-b1cf4',
    storageBucket: 'fishbowl-b1cf4.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBmjLL3bJw_vquf-N1YIRFxxh3OGQYsRk0',
    appId: '1:75060213403:ios:31b24d745015057805783e',
    messagingSenderId: '75060213403',
    projectId: 'fishbowl-b1cf4',
    storageBucket: 'fishbowl-b1cf4.appspot.com',
    iosBundleId: 'com.example.fishbowl',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBmjLL3bJw_vquf-N1YIRFxxh3OGQYsRk0',
    appId: '1:75060213403:ios:cc993d97dba0f4fb05783e',
    messagingSenderId: '75060213403',
    projectId: 'fishbowl-b1cf4',
    storageBucket: 'fishbowl-b1cf4.appspot.com',
    iosBundleId: 'com.example.fishbowl.RunnerTests',
  );
}
