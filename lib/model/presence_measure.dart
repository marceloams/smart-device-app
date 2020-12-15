import 'package:realtimedatabase_teste/model/measure_data.dart';

class PresenceMeasure implements MeasureData{
  @override
  String date;

  @override
  List measures = List(1);

  @override
  String time;

  @override
  var dateParse;

  @override
  String dateTime;

  @override
  List<String> measuresImages = [
    "assets/images/radar_icon.png"
  ];

  @override
  void setMeasureFromMap(Map map) {
    measures[0] = map['presence'];
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