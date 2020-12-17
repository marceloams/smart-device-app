import 'package:flutter/cupertino.dart';
import 'package:realtimedatabase_teste/controller/database_controller.dart';
import 'file:///D:/Users/marce/OneDrive/Documentos/Testes/realtimedatabase_teste/lib/model/device/device_data.dart';
import 'file:///D:/Users/marce/OneDrive/Documentos/Testes/realtimedatabase_teste/lib/model/device/dht11_sensor.dart';
import 'file:///D:/Users/marce/OneDrive/Documentos/Testes/realtimedatabase_teste/lib/model/device/presence_sensor.dart';
import 'package:realtimedatabase_teste/model/timestamp.dart';

class DeviceController {

    DatabaseController dbController = DatabaseController();

    static List<DeviceData> devices = [];

    Future<Null> loadDevices() async{

        devices = [];

        await dbController.readData();

        dbController.data.forEach((key, value) {
            print(value);
            _loadDevice(value);
        });
    }

    void _loadDevice(Map<dynamic,dynamic> data){

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

        dbController.createData(id, deviceData);
    }
}