abstract class MeasureData{
  List<dynamic> measures;
  List<String> measuresImages;
  String date;
  String time;

  void setMeasureFromMap(Map<dynamic, dynamic> map);

  Map<String, dynamic> getMeasureMap();
}