import 'package:firebase_database/firebase_database.dart';

class DeviceDatabase {

  final databaseReference = FirebaseDatabase.instance.reference();

  void createData(String id, Map<String, dynamic> map){
    databaseReference.child(id).set({
      map
    });
  }

  void readData(){
    databaseReference.once().then((DataSnapshot snapshot) {
      print('Data : ${snapshot.value}');
    });
  }

  void updateData(String id, Map<String, dynamic> map){
    databaseReference.child(id).update(
      map
    );
  }

  void deleteData(String id){
    databaseReference.child(id).remove();
  }
}