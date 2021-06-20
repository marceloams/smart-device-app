import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:realtimedatabase_teste/controller/realtime_database_controller.dart';
import 'package:realtimedatabase_teste/controller/device_controller.dart';
import 'package:realtimedatabase_teste/controller/user_controller.dart';
import 'package:realtimedatabase_teste/controller/web_device_controller.dart';
import 'package:realtimedatabase_teste/controller/web_realtime_database_controller.dart';
import 'package:realtimedatabase_teste/model/device/device_data.dart';
import 'package:realtimedatabase_teste/view/widget/afterMethodMessage.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void deleteDeviceAlert(BuildContext context, DeviceData deviceData){

  //Controllers
  DatabaseController dbController = DatabaseController();
  DeviceController deviceController = DeviceController(dbController);
  UserController userController = UserController();
  WebDatabaseController webDbController = WebDatabaseController();
  WebDeviceController webDeviceController = WebDeviceController(webDbController);

  showDialog(
    context:context,
    builder:(BuildContext context){
      return AlertDialog(
        titlePadding: EdgeInsets.only(top: 5.0, left: 10.0, right: 5.0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0))
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Icon(
              Icons.delete,
              color: Theme.of(context).primaryColor,
            ),
            Text(
              ' Delete Device?',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            IconButton(
              icon: Icon(Icons.keyboard_arrow_up),
              onPressed: () {
                Navigator.of(context).pop();
              },
              color: Theme.of(context).primaryColor,
            )
          ],
        ),
        content: new Container(
          width: double.maxFinite,
          padding: EdgeInsets.all(10.0),
          alignment: Alignment.center,
          height: 250.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 25.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 110,
                      child: Text(
                          'Name:',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          )
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        deviceData.name,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                      height: 50.0,
                      child: ElevatedButton(
                        child: Text(
                          'YES',
                          style: TextStyle(fontSize: 18.0, color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColor
                        ),
                        onPressed: (){
                          //create a AfterMethodMessage
                          AfterMethodMessage afterMethodMessage = AfterMethodMessage(context, 'delete device', 3);
                          userController.deleteDevice(deviceData.id);

                          //while firebase_database does not support web version
                          webDeviceController.deleteDevice(deviceData.id,afterMethodMessage);
                          if(!kIsWeb)
                            deviceController.deleteDevice(deviceData.id, afterMethodMessage);
                        },
                      )
                  ),
                  SizedBox(height: 16.0),
                  SizedBox(
                      height: 50.0,
                      child: ElevatedButton(
                        child: Text(
                          'NO',
                          style: TextStyle(fontSize: 18.0, color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColor
                        ),
                        onPressed: (){
                          Navigator.of(context).pop();
                        },
                      )
                  )
                ],
              ),
              SizedBox(height: 5.0),
              Text(
                "Beaware! This action can't be undone!",
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.red
                ),
              ), // to show personalized message
            ],
          ),
        ),
      );
    }
  );

}