import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:realtimedatabase_teste/controller/auth_controller.dart';
import 'package:realtimedatabase_teste/model/user/user_data.dart';
import 'package:realtimedatabase_teste/view/widget/afterMethodMessage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserController {

  bool isLoading = false;

  static UserData userData = UserData();

  UserCredential userCredential;

  AuthController authController = AuthController();

  FirebaseAuth auth = FirebaseAuth.instance;

  _flipIsLoading(){
    isLoading ? isLoading = false : isLoading = true;
  }

  loadUser(){}

  signInEmail(String email, String password, AfterMethodMessage afterMethodMessage) async{
    userCredential = await authController.signInEmail(email, password, afterMethodMessage);
  }

  signInGoogle(AfterMethodMessage afterMethodMessage) async {
    userCredential = await authController.signInGoogle(afterMethodMessage);

    Map<String, dynamic> userMap = {
      'id': userCredential.user.uid,
      'name': userCredential.user.displayName,
      'email': userCredential.user.email,
      'avatar': 'avatar'
    };

    signUpSocialMedia(userMap: userMap);
  }

  signInFacebook(AfterMethodMessage afterMethodMessage) async {
    userCredential = await authController.signInFacebook(afterMethodMessage);

    Map<String, dynamic> userMap = {
      'id': userCredential.user.uid,
      'name': userCredential.user.displayName,
      'email': userCredential.user.email,
      'avatar': 'avatar'
    };

    signUpSocialMedia(userMap: userMap);
  }

  signOut() async {
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
    await FirebaseFirestore.instance.collection('users').doc(userMap['id']).set(userMap); //save data on the firebase
  }

  updateUser(){}

}