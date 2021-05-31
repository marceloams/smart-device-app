import 'package:firebase_auth/firebase_auth.dart';
import 'package:realtimedatabase_teste/controller/auth_controller.dart';
import 'package:realtimedatabase_teste/model/user/user_data.dart';
import 'package:realtimedatabase_teste/view/widget/afterMethodMessage.dart';

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
  }

  signInFacebook(AfterMethodMessage afterMethodMessage) async {
    userCredential = await authController.signInFacebook(afterMethodMessage);
  }

  signOut() async {
    await authController.signOut();
  }

  //recovery password method
  void recoveryPass(String email) {
    auth.sendPasswordResetEmail(email: email); //command to reset email
  }

  updateUser(){}

}