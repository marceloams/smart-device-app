import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:realtimedatabase_teste/view/widget/afterMethodMessage.dart';

enum LoginType {
LOGGED_WITH_EMAIL,
LOGGED_WITH_GMAIL,
LOGGED_WITH_FACEBOOK,
LOGGED_FROM_LOADING
}

class AuthController {

  FirebaseAuth auth;

  AuthController({this.auth}){
    if(this.auth == null) auth = FirebaseAuth.instance;
  }

  static LoginType loginType;

  Future<UserCredential> signInEmail(String email, String password, AfterMethodMessage  afterMethodMessage) async{
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      loginType = LoginType.LOGGED_WITH_EMAIL;
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

  Future<UserCredential> signInGoogle(AfterMethodMessage  afterMethodMessage, {GoogleSignIn googleSignInAux}) async {
    if (kIsWeb) {
      GoogleAuthProvider authProvider = GoogleAuthProvider();

      try {
        final UserCredential userCredential = await auth.signInWithPopup(authProvider);
        loginType = LoginType.LOGGED_WITH_GMAIL;
        return userCredential;
      } catch (e) {
        afterMethodMessage.onFail();
      }
    } else {
      GoogleSignIn googleSignIn;

      if(googleSignInAux != null){
        googleSignIn = googleSignInAux;
      }else {
        googleSignIn = GoogleSignIn();
      }

      final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        try {
          final UserCredential userCredential = await auth.signInWithCredential(credential);
          loginType = LoginType.LOGGED_WITH_GMAIL;
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

        loginType = LoginType.LOGGED_WITH_FACEBOOK;

        // Once signed in, return the UserCredential
        return await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
      } catch (e) {
        afterMethodMessage.onFail();
      }
      return null;
  }

  signOut() async {
    try{
      if(!kIsWeb){
        await signOutGoogle();
        await FacebookAuth.instance.logOut();
        await auth.signOut();
        return;
      }
      switch(loginType){
        case LoginType.LOGGED_WITH_EMAIL:
          await auth.signOut();
          break;
        case LoginType.LOGGED_WITH_GMAIL:
          await signOutGoogle();
          break;
        case LoginType.LOGGED_WITH_FACEBOOK:
          await FacebookAuth.instance.logOut();
          await auth.signOut();
          break;
        default:
          await auth.signOut();
      }
    } catch(e){
      print(e);
    }
  }

  signOutGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      if (!kIsWeb) {
        await googleSignIn.signOut();
      }
      await auth.signOut();
    } catch (e) {
      print(e);
    }
  }

}