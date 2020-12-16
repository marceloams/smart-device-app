class Timestamp {
  String date;
  String time;

  Timestamp(String dateTime){
    var dateParse = DateTime.parse(dateTime);
    date = "${dateParse.day}/${dateParse.month}/${dateParse.year}";
    time = "${dateParse.hour}:${dateParse.minute}:${dateParse.second}";
  }
}