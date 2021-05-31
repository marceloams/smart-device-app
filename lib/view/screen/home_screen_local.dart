import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:realtimedatabase_teste/controller/realtime_database_controller.dart';
import 'package:realtimedatabase_teste/controller/device_controller.dart';
import 'package:realtimedatabase_teste/model/device_example.dart';
import 'package:realtimedatabase_teste/view/screen/add_device_screen.dart';
import 'package:realtimedatabase_teste/view/screen/profile_screen.dart';
import 'package:realtimedatabase_teste/view/tile/devices_tile.dart';

import 'signIn_screen.dart';

class HomeScreenLocal extends StatefulWidget {
  @override
  _HomeScreenLocalState createState() => _HomeScreenLocalState();
}

class _HomeScreenLocalState extends State<HomeScreenLocal> {

  @override
  Widget build(BuildContext context) {

    //Controllers
    DatabaseController dbController = DatabaseController();
    DeviceController deviceController = DeviceController(dbController);

    var dbReference = deviceController.dbController.databaseReference;
    
    //example
    DeviceExample deviceExample = DeviceExample();
    
    deviceController.loadDevices(deviceExample.devices);

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
          FlatButton(
            child: Icon(
                Icons.logout
            ),
            textColor: Colors.white,
            onPressed: (){
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (context)=>SignInScreen()
                  )
              );
            },
          ),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: LayoutBuilder(
          builder: (context, constraints){
            return constraints.maxWidth < 760 ?
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 200.0,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: DeviceController.devices.length,
                        itemBuilder: (context, index) {
                          return (DevicesTile(DeviceController.devices[index], constraints.maxWidth));
                        },
                      ),
                    ),
                  ),
                ],
              ) :
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: SizedBox(
                    height: 800.0,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: DeviceController.devices.length,
                      itemBuilder: (context, index) {
                        return (DevicesTile(DeviceController.devices[index], constraints.maxWidth));
                      },
                    ),
                  ),
                ),
              ],
            );
          },
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