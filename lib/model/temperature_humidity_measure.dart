import 'package:realtimedatabase_teste/model/measure_data.dart';

class TemperatureHumidityMeasure implements MeasureData{
  @override
  String date;

  @override
  List<dynamic> measures;

  @override
  String time;

  @override
  Map<String, dynamic> setMeasureFromMap() {
    // TODO: implement setMeasureFromMap
    throw UnimplementedError();
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