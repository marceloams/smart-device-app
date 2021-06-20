import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:realtimedatabase_teste/controller/auth_controller.dart';
import 'package:realtimedatabase_teste/model/user/user_data.dart';
import 'package:realtimedatabase_teste/view/screen/signIn_screen.dart';
import 'package:realtimedatabase_teste/view/widget/afterMethodMessage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserController {

  bool isLoading = false;

  static UserData userData = UserData();

  static User userFirebase;

  UserCredential userCredential;

  AuthController authController;

  FirebaseAuth auth;

  FirebaseFirestore firestore;

  UserController({this.auth, this.userCredential, this.firestore, this.authController}){
    if(this.auth == null) auth = FirebaseAuth.instance;
    if(this.authController == null) authController = AuthController();
    if(this.firestore == null) firestore = FirebaseFirestore.instance;
  }

  _flipIsLoading(){
    isLoading ? isLoading = false : isLoading = true;
  }

  Future<Null> loadUser(User userFire) async{
    userFirebase = userFire;
    List<String> devicesList = [];
    Map<String, dynamic> userMap;

    DocumentSnapshot<Map<String,dynamic>> userDoc = await firestore.collection('users').doc(userFirebase.uid).get();
    userMap = userDoc.data();

    if(userMap != null){
      QuerySnapshot<Map<String,dynamic>> devicesDoc = await firestore.collection('users').doc(userFirebase.uid).collection('devices').get();
      devicesDoc.docs.forEach((e) {
        devicesList.add(e.id);
      });
      userMap['devices'] = devicesList;

      userData.setFromMap(userMap);
    }
  }

  Future<Null> signInEmail(String email, String password, AfterMethodMessage afterMethodMessage) async{
    userCredential = await authController.signInEmail(email, password, afterMethodMessage);
    loadUser(userCredential.user);
  }

  signInGoogle(AfterMethodMessage afterMethodMessage, {GoogleSignIn googleSignIn}) async {
    if(googleSignIn == null){
      userCredential = await authController.signInGoogle(afterMethodMessage);
    } else {
      userCredential = await authController.signInGoogle(afterMethodMessage, googleSignInAux: googleSignIn);
    }
    if(userCredential==null) return;

    userFirebase = userCredential.user;

    Map<String, dynamic> userMap = {
      'id': userFirebase.uid,
      'name': userFirebase.displayName,
      'email': userFirebase.email,
      'avatar': 'avatar'
    };

    signUpSocialMedia(userMap: userMap);
  }

  signInFacebook(AfterMethodMessage afterMethodMessage) async {
    userCredential = await authController.signInFacebook(afterMethodMessage);
    if(userCredential == null) return;
    userFirebase = userCredential.user;

    Map<String, dynamic> userMap = {
      'id': userFirebase.uid,
      'name': userFirebase.displayName,
      'email': userFirebase.email,
      'avatar': 'avatar'
    };

    signUpSocialMedia(userMap: userMap);
  }

  Future<Null> signOut() async {
    await authController.signOut();
  }

  void recoveryPass(String email) {
    auth.sendPasswordResetEmail(email: email); //command to reset email
  }

  void signUpEmail({@required Map<String, dynamic> userMap, @required String pass, @required AfterMethodMessage afterMethodMessage}) async {

    //try to create an user
    auth.createUserWithEmailAndPassword(
        email: userMap['email'], //pass email from data
        password: pass //and password
    ).then((user) async{ //if its ok
      //add user id to the map
      userMap['id'] = user.user.uid;
      userMap['avatar'] = 'avatar';

      //save the user info
      await _saveUserData(userMap);

      afterMethodMessage.onSuccess();  //calls success function
    }).catchError((e){ //if it is not ok
      afterMethodMessage.onFail(); //calls fail function
      print(e);
    });
  }

  void signUpSocialMedia({@required Map<String, dynamic> userMap}) async {
    try { //if its ok
      await _saveUserData(userMap);
    } catch(e){ //if it is not ok
      print(e);
    }
  }

  //private method to save the user info
  Future<Null> _saveUserData(Map<String, dynamic> userMap) async{
    userData.setFromMap(userMap);
    await firestore.collection('users').doc(userMap['id']).set(userMap); //save data on the firebase
  }

  void updateUser({@required Map<String, dynamic> userMap, @required AfterMethodMessage afterMethodMessage, BuildContext context}) async {
    try{
      if(userMap['email'] != null) {
        userData.setFromMap(userMap);
        await firestore.collection('users').doc(userFirebase.uid).update(userMap);
        userFirebase.updateEmail(userMap['email']);
        signOut();
        afterMethodMessage.methodMessage = 'update email. Please sign in again';
        afterMethodMessage.onSuccess();
        Future.delayed(
            Duration(milliseconds: 2500)
        ).then((_){
          Navigator.of(context).push(
              MaterialPageRoute(builder: (_context) => SignInScreen())
          );
        });
      } else {
        userData.setFromMap(userMap);
        await firestore.collection('users').doc(userFirebase.uid).update(userMap);
        afterMethodMessage.onSuccess();
      }
    }catch(e){
      print(e);
      afterMethodMessage.onFail();
    }
  }
  
  Future<Null> addDevice(String id) async{
    try {
      if(id == null) return;
      Map<String, dynamic> deviceMap = {
        'id': id
      };
      await firestore.collection('users').doc(userFirebase.uid).collection('devices').doc(id).set(deviceMap).then((value) => {userData.devices.add(id)});
    } catch (e){
      print(e);
    }
  }

  Future<Null> deleteDevice(String id) async{
    try {
      if(id == null) return;
      await firestore.collection('users').doc(userFirebase.uid).collection('devices').doc(id).delete().then((value) => {userData.devices.remove(id)});
    } catch (e){
      print(e);
    }
  }

}