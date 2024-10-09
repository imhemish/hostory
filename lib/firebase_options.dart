// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      default:
        throw UnsupportedError(
          'Not yet here for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "AIzaSyD0SC8iXZ9CTzu1ZNgYMOUHR87e0_TpRJY",
    authDomain: "hostory-baf1e.firebaseapp.com",
    projectId: "hostory-baf1e",
    storageBucket: "hostory-baf1e.appspot.com",
    messagingSenderId: "465797543961",
    appId: "1:465797543961:web:c806bd0a51f460d04a5288"
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCP1A2s2IhEMSRNzOz4JanpdldaNIg5-Sk',
    appId: '1:233622925244:android:53cde6a14fa0ba0fe645b9',
    messagingSenderId: '233622925244',
    projectId: 'wawsim-f9f4a',
    storageBucket: 'wawsim-f9f4a.appspot.com',
  );

}