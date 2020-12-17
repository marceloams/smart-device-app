import 'package:flutter/material.dart';
import 'package:realtimedatabase_teste/controller/device_controller.dart';
import 'file:///D:/Users/marce/OneDrive/Documentos/Testes/realtimedatabase_teste/lib/model/device/device_data.dart';
import 'package:realtimedatabase_teste/model/measure/measure_data.dart';

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

  //to get log columns
  List<String> logColumns = [];

  //to get log rows
  List<MeasureData> logRows = [];

  //device controller
  final DeviceController deviceController = DeviceController();

  //constructor to receive deiceData
  _DeviceLogScreenState(this.deviceData){
    deviceName = deviceData.name;

    logColumns = deviceController.getDeviceTypeMeasures(deviceData.mode);
    logColumns.addAll(['Date','Time']);
  }

  //global key to access the scaffold at onSuccess and onFail functions
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  //to create log columns
  List<DataColumn> _getColumns(){

    List<DataColumn> columns = [];

    logColumns.forEach((element) {
      columns.add(
          DataColumn(
              label: Text(
                element,
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              )
          )
      );
    });

    return columns;
  }



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
              ),
              SizedBox(height: 16.0),
              DataTable(
                columns: _getColumns(),
                rows: [],
              ),
              SizedBox(height: 16.0),
              DataTable(
                columns: [
                  DataColumn(
                      label: Text(
                          'Date'
                      )
                  ),
                  DataColumn(
                      label: Text(
                          'Time'
                      )
                  )
                ],
                rows: [
                  DataRow(cells: [
                    DataCell(Text('1')),
                    DataCell(Text('Stephen'))
                  ])
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}