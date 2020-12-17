import 'package:flutter/material.dart';
import 'package:realtimedatabase_teste/controller/device_controller.dart';
import 'file:///D:/Users/marce/OneDrive/Documentos/Testes/realtimedatabase_teste/lib/model/device/device_data.dart';

class DeviceLogScreen extends StatefulWidget {

  //device data to get device info
  final DeviceData deviceData;

  //constructor to receive deiceData
  DeviceLogScreen(this.deviceData);

  @override
  _DeviceLogScreenState createState() => _DeviceLogScreenState(deviceData);
}

class _DeviceLogScreenState extends State<DeviceLogScreen> {
  //device data to get device info
  final DeviceData deviceData;

  //constructor to receive deiceData
  _DeviceLogScreenState(this.deviceData);

  //global key to access the form at the sign up button
  final _formKey = GlobalKey<FormState>();

  //global key to access the scaffold at onSuccess and onFail functions
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  //text field controllers
  final _nameController = TextEditingController();

  //device controller
  final DeviceController deviceController = DeviceController();

  //bool to see if the device has been edited
  bool _deviceEdited = false;

  //Function to get deviceData info
  void _getDeviceDataInfo(){
    _nameController.text = deviceData.name;
  }

  //Function to load page
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _getDeviceDataInfo());
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: (){},
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Device Log"),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}