import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:realtimedatabase_teste/controller/database_controller.dart';
import 'package:realtimedatabase_teste/controller/device_controller.dart';
import 'file:///D:/Users/marce/OneDrive/Documentos/Testes/realtimedatabase_teste/lib/view/tile/devices_tile.dart';
import 'file:///D:/Users/marce/OneDrive/Documentos/Testes/realtimedatabase_teste/lib/view/screen/add_device_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {

    //Controllers
    DatabaseController dbController = DatabaseController();
    DeviceController deviceController = DeviceController(dbController);

    var dbReference = deviceController.dbController.databaseReference;

    return Scaffold(
        appBar: AppBar(
          title: Text("Smart Home"),
          centerTitle: true,
        ),
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StreamBuilder(
                stream: dbReference.onValue,
                builder: (context, snap) {
                  if (snap.hasData && !snap.hasError && snap.data.snapshot.value!=null) {

                    //taking the data snapshot.
                    DataSnapshot snapshot = snap.data.snapshot;
                    Map<dynamic, dynamic> item = {};
                    Map<dynamic, dynamic> _list;
                    //it gives all the documents in this list.
                    _list=snapshot.value;
                    //Now we're just checking if document is not null then add it to another map called "item".
                    _list.forEach((key, value) {
                      if(value != null && !value['reset']) //check if device has been reseted
                        item[key] = value;
                    });

                    //loading items to devices List
                    deviceController.loadDevices(item);

                    return item == null
                    //return sizedbox if there's nothing in database.
                        ? SizedBox()
                        //otherwise return a list of widgets.
                        : Expanded(
                      child: SizedBox(
                        height: 200.0,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: DeviceController.devices.length,
                          itemBuilder: (context, index) {
                            return (
                                DevicesTile(DeviceController.devices[index])
                            );
                          },
                        ),
                      ),
                    );
                  } else {
                    return   Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ],
          ),
        ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add
        ),
        onPressed: (){
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context)=>AddDeviceScreen())
          );
        },
      ),
    );
  }
}