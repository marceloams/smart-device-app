import 'package:flutter/material.dart';
import 'package:realtimedatabase_teste/controller/device_controller.dart';
import 'file:///D:/Users/marce/OneDrive/Documentos/Testes/realtimedatabase_teste/lib/model/device/device_data.dart';

class DeviceLogScreen extends StatefulWidget {

  //device data to get device info
  final DeviceData deviceData;

  //constructor to receive deiceData
  DeviceLogScreen(this.deviceData);

  @override
  _DeviceLogScreenState createState() => _DeviceLogScreenState(deviceData);
}

class _DeviceLogScreenState extends State<DeviceLogScreen> {
  //device data to get device info
  final DeviceData deviceData;

  //variables
  String deviceName;

  //constructor to receive deiceData
  _DeviceLogScreenState(this.deviceData){
    deviceName = deviceData.name;
  }

  //global key to access the scaffold at onSuccess and onFail functions
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  //device controller
  final DeviceController deviceController = DeviceController();

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: (){
        Navigator.pop(context);
        return Future.value(false);
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Device Log"),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(16.0),
          alignment: Alignment.center,
          child: Column(
            children: [
              Text(
                deviceName,
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}