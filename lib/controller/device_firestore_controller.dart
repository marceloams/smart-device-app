import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:realtimedatabase_teste/controller/user_controller.dart';
import 'package:realtimedatabase_teste/model/device/device_data.dart';
import 'package:realtimedatabase_teste/model/device_characteristics/devices_characteristics.dart';
import 'package:realtimedatabase_teste/view/widget/afterMethodMessage.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'realtime_database_controller.dart';

class DeviceFirestoreController with ChangeNotifier {

  static List<DeviceData> devicesList = [];
  static List<Map<String,dynamic>> listAddDevicesToRealtimeDb = [];

  DevicesCharacteristics devicesCharacteristics = DevicesCharacteristics();

  void loadDevices() {
    List<String> devicesIdList = UserController.userData.devices;
    devicesList = [];
    devicesIdList.forEach((element) async {
      await _loadDeviceById(element);
    });
  }

  Future<Null> _loadDeviceById(String id) async {
    DocumentSnapshot<Map<String,dynamic>> deviceDoc = await FirebaseFirestore.instance.collection('devices').doc(id).get();
    Map<String,dynamic> data = deviceDoc.data();
    data['measures'] = await _loadMeasures(id).whenComplete(() => notifyListeners());
    DeviceData device;
    device = devicesCharacteristics.getDeviceInstance(data['mode']);
    device.setFromMap(data);
    devicesList.add(device);
  }

  Future<Map<dynamic,dynamic>> _loadMeasures(String id) async{
    QuerySnapshot<Map<String,dynamic>> deviceMeasures = await FirebaseFirestore.instance.collection('devices').doc(id).collection('measures').get();
    if(deviceMeasures.docs.isEmpty){
      return {
        'measure-1': {
          'temperature': 0,
          'humidity': 0,
          'presence': false,
          'gas': false,
          'timestamp': '2020-06-23 12:30:00'
        }
      };
    }

    Map<dynamic,dynamic> measuresMap = {};

    deviceMeasures.docs.forEach((element) {
      measuresMap.addAll({
        element.id: element.data()
      });
    });

    return measuresMap;
  }

  void deleteDevice(String id,  AfterMethodMessage afterMethodMessage) async{
    try{
      await FirebaseFirestore.instance.collection('devices').doc(id).delete().then((value){
        for(int i=0; i<devicesList.length; i++){
          if(devicesList[i].id == id){
            devicesList.removeAt(i);
            break;
          }
        }
      });
      if(kIsWeb) afterMethodMessage.onSuccess();
    } catch(e){
      print(e);
      if(kIsWeb) afterMethodMessage.onFail();
    }
  }

  void updateDevice(Map<String, dynamic> deviceData, AfterMethodMessage afterMethodMessage) async{
    try{
      await FirebaseFirestore.instance.collection('devices').doc(deviceData['id']).update(deviceData);
      if(kIsWeb) afterMethodMessage.onSuccess();
    } catch(e){
      print(e);
      if(kIsWeb) afterMethodMessage.onFail();
    }
  }

  void loadDevicesFromFirestoreToRealtime() async {
    List<String> devicesIdList = [];
    UserController.userData.devices.forEach((element) {
      devicesIdList.add(element);
    });
    List<String> devicesRemoveIdList = [];
    DatabaseReference databaseReference = FirebaseDatabase.instance.reference();
    DataSnapshot data;

    await databaseReference.once().then((value) => data = value);

    data.value.forEach((rdbId, value){
      devicesIdList.forEach((dId) {
        if(dId == rdbId){
          devicesRemoveIdList.add(dId);
        }
      });
    });

    devicesRemoveIdList.forEach((element) {
      devicesIdList.remove(element);
    });

    if(devicesIdList.isNotEmpty){
      devicesIdList.forEach((dId) async {
        DocumentSnapshot<Map<String,dynamic>> deviceDoc = await FirebaseFirestore.instance.collection('devices').doc(dId).get();
        listAddDevicesToRealtimeDb.add(deviceDoc.data());
        if(devicesIdList.last == dId)
          notifyListeners();
      });
    }
  }

  Future<Null> addDevice(Map<String, dynamic> deviceData, AfterMethodMessage afterMethodMessage) async {
    try{
      await FirebaseFirestore.instance.collection('devices').doc(deviceData['id']).set(deviceData);
      loadDevices();
      if(kIsWeb) afterMethodMessage.onSuccess();
    } catch(e){
      print(e);
      if(kIsWeb) afterMethodMessage.onFail();
    }
  }

  void loadMeasuresFromRealTimeToFirestore(List<DeviceData> dList, DatabaseController dbController) async {

    List<String> removeRealtimeMeasures = [];
    Map<dynamic,dynamic> firestoreMeasures;
    
    for(DeviceData device in dList){
      firestoreMeasures = await _loadMeasures(device.id);
      if(firestoreMeasures.containsKey('measure-1'))
        firestoreMeasures = {};
      DataSnapshot dataSnapshot = await dbController.databaseReference.child(device.id).once();
      Map<dynamic,dynamic> realtimeMeasures = dataSnapshot.value['measures'];
      if(realtimeMeasures != null){
        realtimeMeasures.forEach((key, value) {
          if(firestoreMeasures.containsKey(key)){
            removeRealtimeMeasures.add(key);
          }
        });

        removeRealtimeMeasures.forEach((element) {
          realtimeMeasures.remove(element);
        });

        List<String> listRealtimeIds = [];
        List<Map<String, dynamic>> listRealtimeMaps = [];

        realtimeMeasures.forEach((key, value) {
          listRealtimeMaps.add(new Map<String, dynamic>.from(value));
          listRealtimeIds.add(key.toString());
        });

        for(int i=0;i<listRealtimeIds.length;i++){
          await FirebaseFirestore.instance.collection('devices').doc(device.id).collection('measures').doc(listRealtimeIds[i]).set(listRealtimeMaps[i]);
        }
      }
    }
  }
}