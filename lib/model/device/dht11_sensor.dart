import 'file:///D:/Users/marce/OneDrive/Documentos/Testes/realtimedatabase_teste/lib/model/device/device_data.dart';
import 'file:///D:/Users/marce/OneDrive/Documentos/Testes/realtimedatabase_teste/lib/model/measure/measure_data.dart';
import 'file:///D:/Users/marce/OneDrive/Documentos/Testes/realtimedatabase_teste/lib/model/measure/temperature_humidity_measure.dart';

class Dht11Sensor implements DeviceData {
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
      TemperatureHumidityMeasure temperatureHumidityMeasure = TemperatureHumidityMeasure();
      temperatureHumidityMeasure.setMeasureFromMap(value);
      measures.add(temperatureHumidityMeasure);
    });
  }
}