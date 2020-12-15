abstract class MeasureData{
  List<dynamic> measures;
  String date;
  String time;

  Map<String, dynamic> setMeasureFromMap();

  Map<String, dynamic> getMeasureMap();
}