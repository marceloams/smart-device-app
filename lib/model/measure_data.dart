import 'package:realtimedatabase_teste/model/timestamp.dart';

abstract class MeasureData{
  List<dynamic> measures;
  List<String> measuresImages;
  Timestamp timestamp;

  void setMeasureFromMap(Map<dynamic, dynamic> map);

  Map<String, dynamic> getMeasureMap();
}