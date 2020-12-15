import 'package:firebase_database/firebase_database.dart';

class DatabaseController {
  final databaseReference = FirebaseDatabase.instance.reference();

  Map<dynamic, dynamic> data;

  void createData(String id, Map<String, dynamic> map){
    databaseReference.child(id).set({
      map
    });
  }

  Future<Null> readData() async {
    await databaseReference.once().then((DataSnapshot snapshot) {
      data = snapshot.value;
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