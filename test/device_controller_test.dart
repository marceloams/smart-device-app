import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:realtimedatabase_teste/controller/database_controller.dart';
import 'package:realtimedatabase_teste/controller/device_controller.dart';
import 'package:realtimedatabase_teste/view/widget/afterMethodMessage.dart';

class MockDatabaseController extends Mock implements DatabaseController{}
class MockAfterMethodMeassage extends Mock implements AfterMethodMessage{}

main(){

  TestWidgetsFlutterBinding.ensureInitialized();

  DatabaseController mockDatabaseController = MockDatabaseController();
  DeviceController deviceController = DeviceController(mockDatabaseController);

  AfterMethodMessage mockAfterMethodMessage = MockAfterMethodMeassage();

  group('testing addDevice method',(){
    test('verify if method addDevice is calling methods on correct behalf',() {
      deviceController.addDevice({'id':'id'}, mockAfterMethodMessage);
      verify(deviceController.dbController.createData('id', {'id':'id'}));
      verify(mockAfterMethodMessage.onSuccess());
    });

    test('verify if method addDevice is calling methods on incorrect behalf',() {
      deviceController.addDevice({'id':true}, mockAfterMethodMessage);
      verify(mockAfterMethodMessage.onFail());
    });
  });

  test('returns if method addData is calling createData from DatabaseController',() {
    deviceController.addDevice({'id':'id'}, mockAfterMethodMessage);
    verify(deviceController.dbController.createData('id', {'id':'id'}));
  });
}