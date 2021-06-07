import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:realtimedatabase_teste/controller/realtime_database_controller.dart';
import 'package:realtimedatabase_teste/controller/device_controller.dart';
import 'package:realtimedatabase_teste/controller/user_controller.dart';
import 'package:realtimedatabase_teste/view/screen/add_device_screen.dart';
import 'package:realtimedatabase_teste/view/screen/profile_screen.dart';
import 'package:realtimedatabase_teste/view/tile/devices_tile.dart';

import 'signIn_screen.dart';

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
    UserController userController = UserController();

    var dbReference = deviceController.dbController.databaseReference;

    return Scaffold(
        appBar: AppBar(
          title: Text("Smart Devices"),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.person_rounded,
              size: 32.0,
            ),
            onPressed:() {
              Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context)=>ProfileScreen(context)
                  )
              );
            }
          ),
          actions: <Widget>[
            TextButton(
              child: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              onPressed: () async {
                await userController.signOut();
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context)=>SignInScreen()
                    )
                );
              },
            )
          ],
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
                      if(value != null && !value['reset'] && UserController.userData.devices.contains(value['id'])) //check if device has been reseted and if belongs to user
                        item[key] = value;
                    });

                    //loading items to devices List
                    deviceController.loadDevices(item);

                    return item.isEmpty
                    //return sizedbox if there's nothing in database.
                    ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.mood_bad,
                          size: 150,
                          color: Colors.red
                        ),
                        Text(
                          "You don't have any device!",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 25
                          ),
                        )
                      ],
                    )
                        //otherwise return a list of widgets.
                    : Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0)
                        ),
                        height: 800.0,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: DeviceController.devices.length,
                          itemBuilder: (context, index) {
                            return (
                                DevicesTile(DeviceController.devices[index], 200)
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