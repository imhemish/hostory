import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hostory/home.dart';

class _Login {
  static Future<UserCredential?> _loginWithGoogleOnWeb() async {
    UserCredential? credential;
    try {
    credential = await FirebaseAuth.instance.signInWithPopup(GoogleAuthProvider());
    } catch (e) {
      print(e);
    }
    return credential;
  }

  static Future<UserCredential?> _loginWithGoogleOnMobile() async {
    UserCredential? credential;
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      final googleCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      credential = await FirebaseAuth.instance.signInWithCredential(googleCredential);
    } catch(e) {
      print(e);
    }
    return credential;

  }

  static Future<UserCredential?> loginWithGoogle() async {
    UserCredential? credential;
    if (kIsWeb) {
      credential = await _loginWithGoogleOnWeb();
    } else if (defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS) {
      credential = await _loginWithGoogleOnMobile();
    }
    
    if (credential?.user == null) {
      return null;
    } else {
      return credential;
    }
  }
}

class LoginController {
  static void login(BuildContext context) async {
    var cred = await _Login.loginWithGoogle();
    if (cred != null && context.mounted) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
    } else if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Authentication Failed")));
    }
    
  }
}