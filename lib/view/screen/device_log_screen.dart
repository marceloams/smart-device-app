import 'package:flutter/material.dart';
import 'file:///D:/Users/marce/OneDrive/Documentos/Testes/realtimedatabase_teste/lib/model/device/device_data.dart';
import 'package:realtimedatabase_teste/model/devices_characteristics.dart';

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

  //devices characteristics object
  DevicesCharacteristics devicesCharacteristics = DevicesCharacteristics();

  //to get device name
  String deviceName;

  //to get log columns
  List<String> logColumns = [];

  //constructor to receive deviceData
  _DeviceLogScreenState(this.deviceData){
    deviceName = deviceData.name;

    devicesCharacteristics.getDeviceTypeMeasures(deviceData.mode).forEach((element) {
      logColumns.add(element);
    });
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
              Text(element.timestamp.date)
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
                DataTable(
                  columnSpacing: 0.0,
                  columns: _getDataColumns(),
                  rows: _getDataRows(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}