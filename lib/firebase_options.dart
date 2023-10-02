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
    apiKey: 'AIzaSyBcEY910QBtvGkiYMQtoqnvsNLepweY2RM',
    appId: '1:689206857423:web:65673334130e4a774bf1ba',
    messagingSenderId: '689206857423',
    projectId: 'collectors-mbs',
    authDomain: 'collectors-mbs.firebaseapp.com',
    storageBucket: 'collectors-mbs.appspot.com',
    measurementId: 'G-GC4VT46KMM',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC6odkKzuARXWeBvvbjZZ53uE8cgPPl-34',
    appId: '1:689206857423:android:0b86d75174acd0ad4bf1ba',
    messagingSenderId: '689206857423',
    projectId: 'collectors-mbs',
    storageBucket: 'collectors-mbs.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD5hCS59Kh7lVd2oxzx2NbjZN-UhO2tJ0A',
    appId: '1:689206857423:ios:13dabb1249a8e98a4bf1ba',
    messagingSenderId: '689206857423',
    projectId: 'collectors-mbs',
    storageBucket: 'collectors-mbs.appspot.com',
    iosClientId: '689206857423-blkk01avrs2artchtra2jt1bshjh3vth.apps.googleusercontent.com',
    iosBundleId: 'codespynner.io.collectors',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD5hCS59Kh7lVd2oxzx2NbjZN-UhO2tJ0A',
    appId: '1:689206857423:ios:295056de9de7f6f74bf1ba',
    messagingSenderId: '689206857423',
    projectId: 'collectors-mbs',
    storageBucket: 'collectors-mbs.appspot.com',
    iosClientId: '689206857423-00cltcluujjtmas2rp9hetfj8va44521.apps.googleusercontent.com',
    iosBundleId: 'codespynner.io.collectors.RunnerTests',
  );
}
