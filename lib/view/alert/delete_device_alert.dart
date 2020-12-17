import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:realtimedatabase_teste/controller/device_controller.dart';
import 'file:///D:/Users/marce/OneDrive/Documentos/Testes/realtimedatabase_teste/lib/model/device/device_data.dart';
import 'package:realtimedatabase_teste/view/screen/home_screen.dart';

void deleteDeviceAlert(BuildContext context, DeviceData deviceData){

  DeviceController deviceController = DeviceController();

  //function that executes when update is a success
  void _onSuccess(){

    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Success to delete Device!'),
            backgroundColor: Theme.of(context).primaryColor,
            duration: Duration(seconds: 2)
        )
    );

    //after 2 sec goes to home screen
    Future.delayed(
        Duration(seconds:2)
    ).then((_){
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => HomeScreen())
      );
    });
  }

  //function that executes when update is a fail
  void _onFail(){
    //snack bar with failure information
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Fail to delete Device!'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2)
        )
    );
  }

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
            mainAxisAlignment: MainAxisAlignment.center,
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
              SizedBox(
                height: 50.0,
                child: RaisedButton(
                  child: Text(
                    'YES',
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                  color: Theme.of(context).primaryColor,
                  onPressed: (){
                    deviceController.deleteDevice(deviceData.id, _onSuccess, _onFail);
                  },
                ),
              ),
              SizedBox(height: 16.0),
              SizedBox(
                height: 50.0,
                child:  RaisedButton(
                  child: Text(
                    'NO',
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                  color: Theme.of(context).primaryColor,
                  onPressed: (){
                    Navigator.of(context).pop(); //close alert dialog
                  },
                ),
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