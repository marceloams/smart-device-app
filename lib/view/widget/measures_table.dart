import 'package:flutter/material.dart';
import 'package:realtimedatabase_teste/model/device/device_data.dart';
import 'package:realtimedatabase_teste/model/device_characteristics/devices_characteristics.dart';

class MeasuresTable {

  //device data to get device info
  final DeviceData deviceData;

  //devices characteristics object
  DevicesCharacteristics devicesCharacteristics = DevicesCharacteristics();

  //to get log columns
  List<String> logColumns = [];

  //constructor to receive deviceData
  MeasuresTable(this.deviceData){
    devicesCharacteristics.getDeviceTypeMeasures(deviceData.mode).forEach((element) {
      logColumns.add(element);
    });
    logColumns.addAll(['Time','Date']);
  }

  DataTable getDataTable(){
    return DataTable(
      columnSpacing: 0.0,
      columns: _getDataColumns(),
      rows: _getDataRows(),
    );
  }

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

}