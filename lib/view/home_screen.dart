import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:realtimedatabase_teste/controller/device_controller.dart';
import 'package:realtimedatabase_teste/view/devices_tile.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DeviceController deviceController = DeviceController();

  @override
  Widget build(BuildContext context) {
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
              RaisedButton(
                child: Text("Read data"),
                onPressed: () async{
                  setState((){
                    deviceController.loadDevices().asStream();
                  });
                },
              ),
              Expanded(
                child: SizedBox(
                  height: 200.0,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: DeviceController.devices.length,
                    itemBuilder: (context, index) {
                      return DevicesTile(DeviceController.devices[index]);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add
        ),
        onPressed: (){},
      ),
    );
  }
}