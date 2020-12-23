import 'package:realtimedatabase_teste/controller/database_controller.dart';
import 'package:realtimedatabase_teste/model/devices_characteristics.dart';
import 'file:///D:/Users/marce/OneDrive/Documentos/Testes/realtimedatabase_teste/lib/model/device/device_data.dart';
import 'package:realtimedatabase_teste/view/widget/afterMethodMessage.dart';

class DeviceController {

    DatabaseController dbController;

    DeviceController(this.dbController);

    DevicesCharacteristics devicesCharacteristics = DevicesCharacteristics();

    static List<DeviceData> devices = [];

    int getDevicesLenght(){
        return devices.length;
    }

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

        device = devicesCharacteristics.getDeviceInstance(data['mode']);

        device.setFromMap(data);
        devices.add(device);
    }

    void addDevice(Map<String, dynamic> deviceData, AfterMethodMessage afterMethodMessage){

        try{
            dbController.createData(deviceData['id'], deviceData);
            afterMethodMessage.onSuccess();
        }catch(e){
            afterMethodMessage.onFail();
        }
    }

    void updateDevice(Map<String, dynamic> deviceData, AfterMethodMessage afterMethodMessage){

        try{
            dbController.updateData(deviceData['id'], deviceData);
            afterMethodMessage.onSuccess();
        }catch(e){
            afterMethodMessage.onFail();
        }
    }

    void deleteDevice(String deviceId, AfterMethodMessage afterMethodMessage){

        try{
            if(deviceId == null) throw Exception();
            dbController.deleteData(deviceId);
            dbController.createData(deviceId, {'reset': true});
            afterMethodMessage.onSuccess();
        }catch(e){
            afterMethodMessage.onFail();
        }
    }
}