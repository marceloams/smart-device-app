import 'package:firebase/firebase.dart';

class WebDatabaseController {
  final DatabaseReference databaseReference = database().ref("smarthome-be270-default-rtdb").root;

  Map<dynamic, dynamic> data;

  void createData(String id, Map<String, dynamic> map) {
    databaseReference.child(id).set(map);
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