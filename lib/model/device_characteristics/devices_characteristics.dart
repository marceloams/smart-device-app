import 'package:realtimedatabase_teste/model/device/device_data.dart';
import 'package:realtimedatabase_teste/model/device/dht11_sensor.dart';
import 'package:realtimedatabase_teste/model/device/gas_sensor.dart';
import 'package:realtimedatabase_teste/model/device/presence_sensor.dart';
import 'package:realtimedatabase_teste/model/device_characteristics/devices_characteristics_base.dart';

class DevicesCharacteristics extends DevicesCharacteristicsBase{

  static DevicesCharacteristics _instance = DevicesCharacteristics._internal();

  factory DevicesCharacteristics(){
    return _instance;
  }

  DevicesCharacteristics._internal() {
    initialList = [
      {
        'instance': Dht11Sensor(),
        'name': 'Temperature Sensor',
        'measures-types': ['Humidity', 'Temperature']
      },
      {
        'instance': PresenceSensor(),
        'name': 'Presence Sensor',
        'measures-types': ['Presence']
      },
      {
        'instance': GasSensor(),
        'name': 'Gas Sensor',
        'measures-types': ['Gas']
      }
    ];

    stateList = initialList;
  }

  void _resetInstances(){
    stateList[0]['instance'] = Dht11Sensor();
    stateList[1]['instance'] = PresenceSensor();
    stateList[2]['instance'] = GasSensor();
  }

  DeviceData getDeviceInstance(int type){
    _resetInstances();
    return stateList[type]['instance'];
  }

  String getDeviceType(int type){
    return stateList[type]['name'];
  }

  List<String> getDeviceTypeMeasures(int type){
    return stateList[type]['measures-types'];
  }

}