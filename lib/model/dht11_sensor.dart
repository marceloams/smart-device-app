import 'package:realtimedatabase_teste/model/device_data.dart';
import 'package:realtimedatabase_teste/model/measure_data.dart';
import 'package:realtimedatabase_teste/model/temperature_humidity_measure.dart';

class Dht11Sensor implements DeviceData {
  @override
  String id;

  @override
  int mode;

  @override
  String name;

  @override
  MeasureData measure = TemperatureHumidityMeasure();

  @override
  void setFromMap(Map<dynamic, dynamic> m) {
    id = m['id'];
    name = m['name'];
    mode = m['mode'];

    measure.setMeasureFromMap(m['measures']);
  }
}