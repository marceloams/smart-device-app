import 'package:realtimedatabase_teste/model/measure_data.dart';

abstract class DeviceData {
  String id;
  String name;
  int mode;

  MeasureData measure;

  void setFromMap(Map<dynamic, dynamic> m);
}