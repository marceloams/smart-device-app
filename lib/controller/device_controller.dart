import 'package:realtimedatabase_teste/controller/database_controller.dart';
import 'package:realtimedatabase_teste/model/device_data.dart';
import 'package:realtimedatabase_teste/model/dht11_sensor.dart';
import 'package:realtimedatabase_teste/model/presence_sensor.dart';

class DeviceController {

    DatabaseController dbController = DatabaseController();

    static List<DeviceData> devices = List();

    List<DeviceData> deviceType = [
        Dht11Sensor(),
        PresenceSensor()
    ];

    void loadDevices() async{

        await dbController.readData();

        dbController.data.forEach((key, value) {
            print(value);
            _addDevice(value);
        });
    }

    void _addDevice(Map<dynamic,dynamic> data){

        DeviceData device;

        device = _getDeviceType(data['mode']);

        device.setFromMap(data);
        devices.add(device);
    }

    DeviceData _getDeviceType(int mode){
        return deviceType[mode];
    }
}