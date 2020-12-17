import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:realtimedatabase_teste/controller/device_controller.dart';
import 'file:///D:/Users/marce/OneDrive/Documentos/Testes/realtimedatabase_teste/lib/view/alert/delete_device_alert.dart';
import 'file:///D:/Users/marce/OneDrive/Documentos/Testes/realtimedatabase_teste/lib/model/device/device_data.dart';
import 'home_screen.dart';

class DeviceSettingsScreen extends StatefulWidget {

  //device data to get device info
  DeviceData deviceData;

  //constructor to receive deiceData
  DeviceSettingsScreen(this.deviceData);

  @override
  _DeviceSettingsScreenState createState() => _DeviceSettingsScreenState(deviceData);
}

class _DeviceSettingsScreenState extends State<DeviceSettingsScreen> {
  //device data to get device info
  DeviceData deviceData;

  //constructor to receive deiceData
  _DeviceSettingsScreenState(this.deviceData);

  //global key to access the form at the sign up button
  final _formKey = GlobalKey<FormState>();

  //global key to access the scaffold at onSuccess and onFail functions
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  //text field controllers
  final _nameController = TextEditingController();
  final _idController = TextEditingController();
  final _typeController = TextEditingController();

  //device controller
  final DeviceController deviceController = DeviceController();

  //bool to see if the device has been edited
  bool _deviceEdited = false;

  //Function to get deviceData info
  void _getDeviceDataInfo(){
    _nameController.text = deviceData.name;
    _idController.text = deviceData.id;
    _typeController.text = deviceController.getDeviceType(deviceData.mode);
  }

  //Function to load page
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _getDeviceDataInfo());
  }

  @override
  Widget build(BuildContext context) {

    //function that executes when update is a success
    void _onSuccess(){

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Success to update Device!'),
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
              content: Text('Fail to update Device!'),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 2)
          )
      );
    }

    //Alert Dialog to ask if the user wants to discard the changes
    Future<bool> _requestPop(){
      if(_deviceEdited){
        showDialog(context: context,
            builder: (context){
              return AlertDialog(
                title: Text("Discard Changes?"),
                content: Text("If you leave changes will be lost."),
                actions: <Widget>[
                  FlatButton(
                    child: Text("No"),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                  FlatButton(
                    child: Text("Yes"),
                    onPressed: (){
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            }
        );
        return Future.value(false);
      } else {
        return Future.value(true);
      }
    }

    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Device Settings"),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if(_formKey.currentState.validate() && _deviceEdited) {
              //device map
              Map<String, dynamic> deviceData;

              deviceData = {
                'name': _nameController.text,
              };

              deviceController.updateDevice(deviceData, _idController.text, _onSuccess, _onFail);

            }
          },
          child: Icon(Icons.save),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(20.0),
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Name',
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor
                    ),
                  ),
                  SizedBox(height: 3.0),
                  TextFormField( //full name text field
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: 'Put device name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: 1.3
                        ),
                      ),
                    ),
                    validator: (text){ //rule to validate the input data
                      if(text.isEmpty) return 'Invalid Name!';
                      else return null;
                    },
                    maxLength: 20,
                    onChanged: (text){
                      _deviceEdited = true;
                    },
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Type',
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor
                    ),
                  ),
                  SizedBox(height: 3.0),
                  TextFormField( //full name text field
                    controller: _typeController,
                    enabled: false,
                    decoration: InputDecoration(
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 1.3
                          ),
                        )
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Id',
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor
                    ),
                  ),
                  SizedBox(height: 3.0),
                  TextFormField( //full name text field
                    controller: _idController,
                    enabled: false,
                    decoration: InputDecoration(
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 1.3
                        ),
                      )
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.0),
              Column(
                children: [
                  SizedBox(
                    height: 50.0,
                    child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.copy,
                              color: Colors.white,
                              size: 20.0,
                            ),
                            Text(
                              '  Copy Id',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0
                              ),
                            ),
                          ],
                        ),
                        color: Colors.blueGrey,
                        onPressed: (){
                          FlutterClipboard.copy(_idController.text).then((value){
                            //snack bar with failure information
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('Copied to Clipboard!'),
                                    backgroundColor: Colors.blueGrey,
                                    duration: Duration(seconds: 2)
                                )
                            );
                          });
                        }
                    ),
                  ),
                  SizedBox(height: 25.0),
                  SizedBox(
                    height: 50.0,
                    child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.delete,
                              color: Colors.white,
                              size: 20.0,
                            ),
                            Text(
                              '  Delete Device',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0
                              ),
                            ),
                          ],
                        ),
                        color: Colors.red,
                        onPressed: (){
                          DeleteDeviceAlert(context, deviceData);
                        }
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}