import 'file:///D:/Users/marce/OneDrive/Documentos/Testes/realtimedatabase_teste/lib/model/device/device_data.dart';
import 'file:///D:/Users/marce/OneDrive/Documentos/Testes/realtimedatabase_teste/lib/model/device/dht11_sensor.dart';
import 'file:///D:/Users/marce/OneDrive/Documentos/Testes/realtimedatabase_teste/lib/model/device/presence_sensor.dart';

class DevicesCharacteristics {

  DeviceData getDeviceInstance(int mode){
    List<DeviceData> deviceType = [
      Dht11Sensor(),
      PresenceSensor()
    ];

    return deviceType[mode];
  }

  String getDeviceType(int type){
    List<String> types = [
      'Temperature Sensor',
      'Presence Sensor'
    ];

    return types[type];
  }

  List<String> getDeviceTypeMeasures(int type){
    List<List<String>> types = [
      ['Humidity', 'Temperature'],
      ['Presence']
    ];

    return types[type];
  }

}