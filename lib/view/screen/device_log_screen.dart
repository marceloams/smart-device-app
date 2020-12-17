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

  //to get device name
  String deviceName;

  //to get log columns
  List<String> logColumns = [];

  //device controller
  final DeviceController deviceController = DeviceController();

  //constructor to receive deiceData
  _DeviceLogScreenState(this.deviceData){
    deviceName = deviceData.name;

    logColumns = deviceController.getDeviceTypeMeasures(deviceData.mode);
    logColumns.addAll(['Time','Date']);
  }

  //global key to access the scaffold at onSuccess and onFail functions
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  //to create log columns
  List<DataColumn> _getDataColumns(){

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

  //to create log rows
  List<DataRow> _getDataRows(){

    List<DataRow> rows = [];
    List<DataCell> cells;

    deviceData.measures.forEach((element) {

      cells = [];

      for(int i = 0; i<element.measures.length; i++){
        cells.add(
            DataCell(
                Text(element.measures[i].toString() + element.units[i])
            )
        );
      }

      cells.add(
          DataCell(
              Text(element.timestamp.time)
          )
      );

      cells.add(
          DataCell(
              Text(element.timestamp.time)
          )
      );

      rows.add(
        DataRow(cells: cells)
      );

    });

    return rows;
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
              DataTable(
                columns: _getDataColumns(),
                rows: _getDataRows(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}