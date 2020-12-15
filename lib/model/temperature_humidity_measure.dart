import 'package:realtimedatabase_teste/model/measure_data.dart';

class TemperatureHumidityMeasure implements MeasureData{
  @override
  String date;

  @override
  List<dynamic> measures = List(2);

  @override
  String time;

  @override
  var dateParse;

  @override
  List<String> measuresImages = [
    'assets/images/humidity_icon.png',
    'assets/images/thermometer_icon.png'
  ];

  @override
  void setMeasureFromMap(Map<dynamic, dynamic> map) {
    measures[0] = map['humidity'];
    measures[1] = map['temperature'];
  }

  @override
  Map<String, dynamic> getMeasureMap() {
    return {
      'temperature': measures[0],
      'humidity': measures[1],
      'date': date,
      'time': time
    };
  }
}