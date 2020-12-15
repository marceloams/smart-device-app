import 'package:realtimedatabase_teste/model/measure_data.dart';

abstract class DeviceData {
  String id;
  String name;
  String mode;

  MeasureData measure;

  DeviceData(this.id, this.name, this.mode);
}