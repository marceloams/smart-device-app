import 'package:realtimedatabase_teste/model/measure_data.dart';

class PresenceMeasure implements MeasureData{
  @override
  String date;

  @override
  List measures;

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
      'presence': measures[0],
      'date': date,
      'time': time
    };
  }
}