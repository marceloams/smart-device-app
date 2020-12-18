class Timestamp {
  String date;
  String time;
  int toCompare;

  Timestamp(String dateTime){
    var dateParse = DateTime.parse(dateTime);

    toCompare = dateParse.millisecondsSinceEpoch;
    date = "${dateParse.day}/${dateParse.month}/${dateParse.year}";
    time = "${dateParse.hour}:${dateParse.minute}:${dateParse.second}";
  }
}