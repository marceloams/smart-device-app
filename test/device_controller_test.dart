import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:realtimedatabase_teste/controller/database_controller.dart';
import 'package:realtimedatabase_teste/controller/device_controller.dart';
import 'package:realtimedatabase_teste/view/widget/afterMethodMessage.dart';

class MockDatabaseController extends Mock implements DatabaseController{}
class MockAfterMethodMeassage extends Mock implements AfterMethodMessage{}

main(){

  DatabaseController mockDatabaseController = MockDatabaseController();
  DeviceController deviceController = DeviceController(mockDatabaseController);

  AfterMethodMessage mockAfterMethodMessage = MockAfterMethodMeassage();

  group('Testing DeviceController Methods', (){

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