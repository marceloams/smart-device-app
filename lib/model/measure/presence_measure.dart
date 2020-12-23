import 'package:realtimedatabase_teste/model/measure/measure_data.dart';
import 'package:realtimedatabase_teste/model/timestamp.dart';

class PresenceMeasure implements MeasureData{
  @override
  List measures = [1];

  @override
  List<String> units = [' '];

  @override
  Timestamp timestamp;

  @override
  List<String> measuresImages = [
    "assets/images/radar_icon.png"
  ];

  @override
  void setMeasureFromMap(Map map) {
    measures[0] = map['presence'];
    timestamp = Timestamp(map['timestamp']);
  }

  @override
  Map<String, dynamic> getMeasureMap() {
    return {
      'presence': measures[0],
      'date': timestamp.date,
      'time': timestamp.time
    };
  }
}