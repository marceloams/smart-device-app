import 'package:flutter/cupertino.dart';
import 'package:realtimedatabase_teste/controller/database_controller.dart';
import 'file:///D:/Users/marce/OneDrive/Documentos/Testes/realtimedatabase_teste/lib/model/device/device_data.dart';
import 'file:///D:/Users/marce/OneDrive/Documentos/Testes/realtimedatabase_teste/lib/model/device/dht11_sensor.dart';
import 'file:///D:/Users/marce/OneDrive/Documentos/Testes/realtimedatabase_teste/lib/model/device/presence_sensor.dart';

class DeviceController {

    DatabaseController dbController = DatabaseController();

    static List<DeviceData> devices = [];

    Future<Null> loadDevices() async{

        devices = [];

        await dbController.readData();

        dbController.data.forEach((key, value) {
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

    void addDevice(Map<String, dynamic> deviceData, VoidCallback onSuccess, VoidCallback onFail){
        String id = (DateTime.now().millisecondsSinceEpoch + devices.length).toString();
        bool reset = false;

        deviceData['id'] = id;
        deviceData['reset'] = reset;

        try{
            dbController.createData(id, deviceData);
            onSuccess();
        }catch(e){
            onFail();
        }
    }
}