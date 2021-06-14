import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';
import 'package:mockito/mockito.dart';
import 'package:realtimedatabase_teste/controller/auth_controller.dart';
import 'package:realtimedatabase_teste/controller/realtime_database_controller.dart';
import 'package:realtimedatabase_teste/controller/user_controller.dart';
import 'package:realtimedatabase_teste/model/user/user_data.dart';
import 'package:realtimedatabase_teste/view/widget/afterMethodMessage.dart';

class MockDatabaseController extends Mock implements DatabaseController{}
class MockAfterMethodMessage extends Mock implements AfterMethodMessage{}
class MockUserCredential extends Mock implements UserCredential{}

main(){

  final User mockUser = MockUser(
    isAnonymous: false,
    uid: 'userId',
    email: 'nick@email.com',
    displayName: 'Nick',
  );

  AfterMethodMessage mockAfterMethodMessage = MockAfterMethodMessage();

  UserCredential mockUserCredential = MockUserCredential();
  FirebaseAuth mockFirebaseAuth = MockFirebaseAuth(mockUser: mockUser);
  FirebaseFirestore fakeFirestore = FakeFirebaseFirestore();

  AuthController authController = AuthController(auth: mockFirebaseAuth);

  UserController userController = UserController(auth: mockFirebaseAuth, authController: authController, firestore: fakeFirestore, userCredential: mockUserCredential);

  UserController.userFirebase = mockUser;

  MockGoogleSignIn googleSignIn = MockGoogleSignIn();

  fakeFirestore.collection('users').doc('userId').set({
    'avatar': 'avatar',
    'email': 'nick@email.com',
    'id': 'userId',
    'name': 'Nick'
  });

  group('Testing UserController Methods', (){

    //loadUser method
    group('Testing loadUser method', (){
      test("testing if is not loading user that doesn't exist",() async {
        User mockUser2 = MockUser(
          isAnonymous: false,
          uid: 'notUser',
          email: 'notUser@email.com',
          displayName: 'notUser'
        );
        await userController.loadUser(mockUser2);
        expect(UserController.userData.id,null);
      });

      test('testing if is loading user',() async {
        await userController.loadUser(mockUser);
        expect(UserController.userData.id,'userId');
      });
    });

    //signIn method
    group('Testing signIn method',() {
      test('verify signIn with email',() async {
        await userController.signInEmail('nick@email.com', '12345678', mockAfterMethodMessage);
        expect(userController.userCredential.user, mockUser);
      });

      test('verify signIn with gmail',() async {
        await userController.signInGoogle(mockAfterMethodMessage, googleSignIn: googleSignIn);
        expect(userController.userCredential.user, mockUser);
      });
    });

    //signOut method
    test('verify signOut',() async {
      FirebaseAuth mockAuth = MockFirebaseAuth(signedIn: true, mockUser: mockUser);
      AuthController mockAuthController = AuthController(auth: mockAuth);
      userController.auth = mockAuth;
      userController.authController = mockAuthController;
      await userController.signOut();
      expect(userController.authController.auth.currentUser, mockUser);
    });

    //addDevice method
    group('Testing addDevice method',(){
      test('verify if is adding a device to user',() async{
        UserController.userData = UserData();
        await userController.addDevice('deviceId');
        expect(UserController.userData.devices.length, 1);
      });

      test('verify if is not adding a device to user',() async{
        UserController.userData = UserData();
        await userController.addDevice(null);
        expect(UserController.userData.devices.length, 0);
      });
    });

    //deleteDevice method
    group('Testing deleteDevice method',(){
      test('Verify if is deleting device',() async{
        UserController.userData.devices = [];
        await userController.addDevice('deviceId');
        await userController.deleteDevice('deviceId');
        expect(UserController.userData.devices.length, 0);
      });

      test('Verify if is not deleting device',() async{
        UserController.userData.devices = [];
        await userController.addDevice('deviceId');
        await userController.deleteDevice(null);
        expect(UserController.userData.devices.length, 1);
      });
    });
  });
}

class FakeAuthCredential implements AuthCredential {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}