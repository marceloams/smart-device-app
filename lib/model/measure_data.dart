abstract class MeasureData{
  List<dynamic> measures;
  List<String> measuresImages;
  var dateParse;
  String date;
  String time;

  void setMeasureFromMap(Map<dynamic, dynamic> map){
    _setTimeData(map['timestamp']);
  }

  Map<String, dynamic> getMeasureMap();

  _setTimeData(String dateTime){
    //to get time and date formatted
    dateParse = DateTime.parse(dateTime);
    date = "${dateParse.day}/${dateParse.month}/${dateParse.year}";
    time = "${dateParse.hour}:${dateParse.minute}:${dateParse.second}";
  }
}