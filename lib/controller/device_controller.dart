import 'package:flutter/cupertino.dart';
import 'package:realtimedatabase_teste/controller/database_controller.dart';
import 'file:///D:/Users/marce/OneDrive/Documentos/Testes/realtimedatabase_teste/lib/model/device/device_data.dart';
import 'file:///D:/Users/marce/OneDrive/Documentos/Testes/realtimedatabase_teste/lib/model/device/dht11_sensor.dart';
import 'file:///D:/Users/marce/OneDrive/Documentos/Testes/realtimedatabase_teste/lib/model/device/presence_sensor.dart';
import 'package:realtimedatabase_teste/view/widget/afterMethodMessage.dart';

class DeviceController {

    DatabaseController dbController = DatabaseController();

    static List<DeviceData> devices = [];

    Future<Null> loadDevices(Map<dynamic,dynamic> data) async{

        devices = [];

        data.forEach((key, value) {
           _loadDevice(value);
        });
    }

    void _loadDevice(Map<dynamic,dynamic> data){

        //if device is new and has no measure data
        if(!data.containsKey('measures')){
            Map<String, dynamic> measures = {
                'measure-1': {
                    'temperature': 0,
                    'humidity': 0,
                    'presence': false,
                    'timestamp': '2020-06-23 12:30:00'
                }
            };
            data['measures'] = measures;
        }

        DeviceData device;

        device = _getDeviceType(data['mode']);

        device.setFromMap(data);
        devices.add(device);
    }

    DeviceData _getDeviceType(int mode){
        List<DeviceData> deviceType = [
            Dht11Sensor(),
            PresenceSensor()
        ];

        return deviceType[mode];
    }

    void addDevice(Map<String, dynamic> deviceData, BuildContext context, int numberOfPops){

        AfterMethodMessage afterMethodMessage = AfterMethodMessage(context, 'add device', numberOfPops);

        String id = (DateTime.now().millisecondsSinceEpoch + devices.length).toString();
        bool reset = false;

        deviceData['id'] = id;
        deviceData['reset'] = reset;

        try{
            dbController.createData(id, deviceData);
            afterMethodMessage.onSuccess();
        }catch(e){
            afterMethodMessage.onFail();
        }
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

    void updateDevice(Map<String, dynamic> deviceData, String deviceId, BuildContext context, int numberOfPops){

        AfterMethodMessage afterMethodMessage = AfterMethodMessage(context, 'update device', numberOfPops);

        try{
            dbController.updateData(deviceId, deviceData);
            afterMethodMessage.onSuccess();
        }catch(e){
            afterMethodMessage.onFail();
        }
    }

    void deleteDevice(String deviceId, BuildContext context, int numberOfPops){

        AfterMethodMessage afterMethodMessage = AfterMethodMessage(context, 'delete device', numberOfPops);

        try{
            dbController.deleteData(deviceId);
            dbController.createData(deviceId, {'reset': true});
            afterMethodMessage.onSuccess();
        }catch(e){
            afterMethodMessage.onFail();
        }
    }
}