import 'package:realtimedatabase_teste/controller/database_controller.dart';
import 'file:///D:/Users/marce/OneDrive/Documentos/Testes/realtimedatabase_teste/lib/model/device/device_data.dart';
import 'file:///D:/Users/marce/OneDrive/Documentos/Testes/realtimedatabase_teste/lib/model/device/dht11_sensor.dart';
import 'file:///D:/Users/marce/OneDrive/Documentos/Testes/realtimedatabase_teste/lib/model/device/presence_sensor.dart';

class DeviceController {

    DatabaseController dbController = DatabaseController();

    static List<DeviceData> devices = [];

    List<DeviceData> deviceType = [
        Dht11Sensor(),
        PresenceSensor()
    ];

    Future<Null> loadDevices() async{

        devices = [];

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