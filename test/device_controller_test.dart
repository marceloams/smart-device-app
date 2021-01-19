import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:realtimedatabase_teste/controller/database_controller.dart';
import 'package:realtimedatabase_teste/controller/device_controller.dart';
import 'package:realtimedatabase_teste/view/widget/afterMethodMessage.dart';

class MockDatabaseController extends Mock implements DatabaseController{}
class MockAfterMethodMessage extends Mock implements AfterMethodMessage{}

main(){

  DatabaseController mockDatabaseController = MockDatabaseController();
  DeviceController deviceController = DeviceController(mockDatabaseController);

  AfterMethodMessage mockAfterMethodMessage = MockAfterMethodMessage();

  group('Testing DeviceController Methods', (){

    //loadDevice method
    group('Testing loadDevice method',(){

      test('testing if is loading a device with no measures data',() {

        //map of device
        Map<dynamic, dynamic> devices = {
          'device-1':{
            'id': 'id',
            'name': 'dht11 sensor',
            'mode': 0,
            'reset': false
          }
        };

        deviceController.loadDevices(devices);
        expect(deviceController.getDevicesLength(), 1);
      });

      test('testing if is loading a devices with measures data',() {

        //map of device
        Map<dynamic, dynamic> devices = {
          'device-1':{
            'id': 'id',
            'name': 'dht11 sensor',
            'mode': 0,
            'reset': false,
            'measures': {
              'measure-1': {
                'temperature': 0,
                'humidity': 0,
                'presence': false,
                'timestamp': '2020-06-23 12:30:00'
              }
            }
          }
        };

        deviceController.loadDevices(devices);
        expect(deviceController.getDevicesLength(), 1);
      });
    });

    //addDevice method
    group('Testing addDevice method',(){
      test('verify if is calling methods with no error',() {
        deviceController.addDevice({'id':'id'}, mockAfterMethodMessage);
        verify(deviceController.dbController.createData('id', {'id':'id'}));
        verify(mockAfterMethodMessage.onSuccess());
      });

      test('Verify if is calling methods with error',() {
        deviceController.addDevice({'id':true}, mockAfterMethodMessage);
        verify(mockAfterMethodMessage.onFail());
      });
    });

    //updateDevice method
    group('Testing updateDevice method',(){
      test('verify if is calling methods with no error',() {
        deviceController.updateDevice({'id': 'id'}, mockAfterMethodMessage);
        verify(deviceController.dbController.updateData('id', {'id':'id'}));
        verify(mockAfterMethodMessage.onSuccess());
      });

      test('Verify if is calling methods with error',() {
        deviceController.updateDevice({'id':true}, mockAfterMethodMessage);
        verify(mockAfterMethodMessage.onFail());
      });
    });

    //deleteDevice method
    group('Testing deleteDevice method',(){
      test('Verify if is calling methods with no error',() {
        deviceController.deleteDevice('id', mockAfterMethodMessage);
        verify(deviceController.dbController.deleteData('id'));
        verify(mockAfterMethodMessage.onSuccess());
      });

      test('Verify if is calling methods with error',() {
        deviceController.deleteDevice(null, mockAfterMethodMessage);
        verify(mockAfterMethodMessage.onFail());
      });
    });
  });
}