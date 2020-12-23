import 'package:realtimedatabase_teste/model/measure/measure_data.dart';
import 'package:realtimedatabase_teste/model/timestamp.dart';

class TemperatureHumidityMeasure implements MeasureData{
  @override
  List<dynamic> measures = [0,1];

  @override
  List<String> units = ['%', '°C'];

  @override
  Timestamp timestamp;

  @override
  List<String> measuresImages = [
    'assets/images/humidity_icon.png',
    'assets/images/thermometer_icon.png'
  ];

  @override
  void setMeasureFromMap(Map<dynamic, dynamic> map) {
    measures[0] = map['humidity'];
    measures[1] = map['temperature'].toStringAsFixed(2);
    timestamp = Timestamp(map['timestamp']);
  }

  @override
  Map<String, dynamic> getMeasureMap() {
    return {
      'temperature': measures[0],
      'humidity': measures[1],
      'date': timestamp.date,
      'time': timestamp.time
    };
  }
}