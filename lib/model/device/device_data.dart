import 'file:///D:/Users/marce/OneDrive/Documentos/Testes/realtimedatabase_teste/lib/model/measure/measure_data.dart';

abstract class DeviceData {
  String id;
  String name;
  int mode;

  List<MeasureData> measures;

  void setFromMap(Map<dynamic, dynamic> m);
}