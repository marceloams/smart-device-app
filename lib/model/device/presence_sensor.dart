import 'package:realtimedatabase_teste/model/device/device_data.dart';
import 'package:realtimedatabase_teste/model/measure/measure_data.dart';
import 'package:realtimedatabase_teste/model/measure/presence_measure.dart';

class PresenceSensor implements DeviceData{
  @override
  String id;

  @override
  int mode;

  @override
  String name;

  @override
  List<MeasureData> measures = [];

  @override
  void setFromMap(Map<dynamic, dynamic> m) {
    id = m['id'];
    name = m['name'];
    mode = m['mode'];

    m['measures'].forEach((key, value) {
      PresenceMeasure presenceMeasure = PresenceMeasure();
      presenceMeasure.setMeasureFromMap(value);
      measures.add(presenceMeasure);
    });

    measures.sort((m1, m2) {
      var r = m2.timestamp.toCompare.compareTo(m1.timestamp.toCompare);
      if (r != 0) return r;
      return m2.timestamp.toCompare.compareTo(m1.timestamp.toCompare);
    });
  }
}