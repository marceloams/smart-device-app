import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<DocumentSnapshot<Map<String,dynamic>>> getUserDoc(User userFirebase) async{
    return await firestore.collection('users').doc(userFirebase.uid).get();
  }

  Future<QuerySnapshot<Map<String,dynamic>>> getDevicesDoc(User userFirebase) async {
    return await firestore.collection('users').doc(userFirebase.uid).collection('devices').get();
  }
}