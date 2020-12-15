import 'package:realtimedatabase_teste/model/device_data.dart';
import 'package:realtimedatabase_teste/model/measure_data.dart';
import 'package:realtimedatabase_teste/model/presence_measure.dart';

class PresenceSensor implements DeviceData{
  @override
  String id;

  @override
  int mode;

  @override
  String name;

  @override
  MeasureData measure = PresenceMeasure();

  @override
  void setFromMap(Map<dynamic, dynamic> m) {
    id = m['id'];
    name = m['name'];
    mode = m['mode'];
  }
}