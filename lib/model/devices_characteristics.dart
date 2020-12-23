import 'file:///D:/Users/marce/OneDrive/Documentos/Testes/realtimedatabase_teste/lib/model/device/device_data.dart';
import 'file:///D:/Users/marce/OneDrive/Documentos/Testes/realtimedatabase_teste/lib/model/device/dht11_sensor.dart';
import 'file:///D:/Users/marce/OneDrive/Documentos/Testes/realtimedatabase_teste/lib/model/device/presence_sensor.dart';

class DevicesCharacteristics {

  List<Map<dynamic,dynamic>> devices = [
    {
      'name': 'Temperature Sensor',
      'measures-types': ['Humidity', 'Temperature']
    },
    {
      'name': 'Presence Sensor',
      'measures-types': ['Presence']
    }
  ];

  void _setInstances(){
    devices[0]['instance'] = Dht11Sensor();
    devices[1]['instance'] = PresenceSensor();
  }

  DeviceData getDeviceInstance(int type){
    _setInstances();
    return devices[type]['instance'];
  }

  String getDeviceType(int type){
    return devices[type]['name'];
  }

  List<String> getDeviceTypeMeasures(int type){
    return devices[type]['measures-types'];
  }

}