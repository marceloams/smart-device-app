import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:realtimedatabase_teste/controller/database_controller.dart';
import 'package:realtimedatabase_teste/controller/device_controller.dart';
import 'package:realtimedatabase_teste/model/devices_characteristics.dart';
import 'file:///D:/Users/marce/OneDrive/Documentos/Testes/realtimedatabase_teste/lib/view/alert/delete_device_alert.dart';
import 'file:///D:/Users/marce/OneDrive/Documentos/Testes/realtimedatabase_teste/lib/model/device/device_data.dart';
import 'package:realtimedatabase_teste/view/alert/request_pop_alert.dart';
import 'package:realtimedatabase_teste/view/widget/afterMethodMessage.dart';

class DeviceSettingsScreen extends StatefulWidget {

  //device data to get device info
  final DeviceData deviceData;

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

  //devices characteristics object
  DevicesCharacteristics devicesCharacteristics = DevicesCharacteristics();

  //global key to access the form at the sign up button
  final _formKey = GlobalKey<FormState>();

  //global key to access the scaffold at onSuccess and onFail functions
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  //text field controllers
  final _nameController = TextEditingController();
  final _idController = TextEditingController();
  final _typeController = TextEditingController();

  //bool to see if the device has been edited
  bool _deviceEdited = false;

  //Function to get deviceData info
  void _getDeviceDataInfo(){
    _nameController.text = deviceData.name;
    _idController.text = deviceData.id;
    _typeController.text = devicesCharacteristics.getDeviceType(deviceData.mode);
  }

  //Function to load page
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _getDeviceDataInfo());
  }

  @override
  Widget build(BuildContext context) {

    //Device Controller
    DatabaseController dbController = DatabaseController();
    DeviceController deviceController = DeviceController(dbController);

    RequestPopAlert requestPopAlert = RequestPopAlert(context, _deviceEdited, 'changes');

    return WillPopScope(
      onWillPop: requestPopAlert.getRequestPopAlert,
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
                'id': _idController.text,
                'name': _nameController.text,
              };

              //create a AfterMethodMessage
              AfterMethodMessage afterMethodMessage = AfterMethodMessage(context, 'update device', 2);

              deviceController.updateDevice(deviceData, afterMethodMessage);

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
                      requestPopAlert.edited= _deviceEdited;
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
                          deleteDeviceAlert(context, deviceData);
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