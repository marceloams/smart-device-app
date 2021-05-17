import 'package:flutter/material.dart';
import 'package:realtimedatabase_teste/model/device/device_data.dart';
import 'package:realtimedatabase_teste/view/widget/measures_table.dart';

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

  //to get device name
  String deviceName;

  //to make measures table
  MeasuresTable measuresTable;

  //constructor to receive deviceData
  _DeviceLogScreenState(this.deviceData){
    deviceName = deviceData.name;
    measuresTable = MeasuresTable(deviceData);
  }

  //global key to access the scaffold at onSuccess and onFail functions
  final _scaffoldKey = GlobalKey<ScaffoldState>();

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
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16.0),
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  deviceName,
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                measuresTable.getDataTable()
              ],
            ),
          ),
        ),
      ),
    );
  }
}