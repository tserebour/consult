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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDMTwdAledTikOBQ2JzCfZbtxAKbsQYOwc',
    appId: '1:504601272345:android:f39eb1959e27645975ca88',
    messagingSenderId: '504601272345',
    projectId: 'consult-40b35',
    storageBucket: 'consult-40b35.appspot.com',



  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCTEG5W7IBQqS6j982hm5CFqMINmiGrBxA',
    appId: '1:504601272345:ios:35906eb8f39eebeb75ca88',
    messagingSenderId: '504601272345',
    projectId: 'consult-40b35',
    storageBucket: 'consult-40b35.appspot.com',
    iosClientId: '504601272345-p0tcrbtgruqgc86tui66r7a8e8dr21aq.apps.googleusercontent.com',
    iosBundleId: 'com.example.consult',
  );
}