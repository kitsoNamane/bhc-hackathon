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
    apiKey: 'AIzaSyC9RDGQ_u8nRN5qL996xRRfdM8mPB_GceY',
    appId: '1:614247489670:web:b79f98993f537f105a7107',
    messagingSenderId: '614247489670',
    projectId: 'bcc-hackathon-fad61',
    authDomain: 'bcc-hackathon-fad61.firebaseapp.com',
    storageBucket: 'bcc-hackathon-fad61.appspot.com',
    measurementId: 'G-ZWVK5062BJ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAYCYhL50vUTC0uCgYqOjfukRmD-dpOO24',
    appId: '1:614247489670:android:25ed146f94fa505e5a7107',
    messagingSenderId: '614247489670',
    projectId: 'bcc-hackathon-fad61',
    storageBucket: 'bcc-hackathon-fad61.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyADJhoPT7iirpsr5gjf9pjqGFOdWbTzEOM',
    appId: '1:614247489670:ios:79818e299104319c5a7107',
    messagingSenderId: '614247489670',
    projectId: 'bcc-hackathon-fad61',
    storageBucket: 'bcc-hackathon-fad61.appspot.com',
    iosClientId: '614247489670-vpg4a0blfjr4mlaae73kiqg33ndta1s7.apps.googleusercontent.com',
    iosBundleId: 'com.example.bhcHackathon',
  );
}
