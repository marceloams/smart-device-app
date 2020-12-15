import 'package:firebase_database/firebase_database.dart';

class DatabaseController {
  final databaseReference = FirebaseDatabase.instance.reference();

  Map<dynamic, dynamic> m;

  void createData(String id, Map<String, dynamic> map){
    databaseReference.child(id).set({
      map
    });
  }

  void readData(){
    databaseReference.once().then((DataSnapshot snapshot) {
      m = snapshot.value;
      print(m);
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