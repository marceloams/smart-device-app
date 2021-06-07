import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:realtimedatabase_teste/view/widget/afterMethodMessage.dart';

class AuthController {

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<UserCredential> signInEmail(String email, String password, AfterMethodMessage  afterMethodMessage) async{
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        afterMethodMessage.onFail();
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        afterMethodMessage.onFail();
      }
    }
    return null;
  }

  Future<UserCredential> signInGoogle(AfterMethodMessage  afterMethodMessage) async {
    if (kIsWeb) {
      GoogleAuthProvider authProvider = GoogleAuthProvider();

      try {
        final UserCredential userCredential = await auth.signInWithPopup(authProvider);
        return userCredential;
      } catch (e) {
        afterMethodMessage.onFail();
      }
    } else {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        try {
          final UserCredential userCredential = await auth.signInWithCredential(credential);
          return userCredential;
        } on FirebaseAuthException catch (e) {
          if (e.code == 'account-exists-with-different-credential') {
            afterMethodMessage.onFail();
          }
          else if (e.code == 'invalid-credential') {
            afterMethodMessage.onFail();
          }
        } catch (e) {
          afterMethodMessage.onFail();
        }
      }
    }
    return null;
  }

  Future<UserCredential> signInFacebook(AfterMethodMessage  afterMethodMessage) async{
      try{
        // Trigger the sign-in flow
        final LoginResult result = await FacebookAuth.instance.login();

        // Create a credential from the access token
        final facebookAuthCredential = FacebookAuthProvider.credential(result.accessToken.token);

        // Once signed in, return the UserCredential
        return await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
      } catch (e) {
        afterMethodMessage.onFail();
      }
      return null;
  }

  signOut() async {
    await signOutGoogle();
    await FacebookAuth.instance.logOut();
    await auth.signOut();
  }

  signOutGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      if (!kIsWeb) {
        await googleSignIn.signOut();
      }
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      //handle error
    }
  }

}