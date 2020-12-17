import 'package:flutter/material.dart';
import 'package:realtimedatabase_teste/controller/device_controller.dart';
import 'home_screen.dart';

class AddDeviceScreen extends StatefulWidget {
  @override
  _AddDeviceScreenState createState() => _AddDeviceScreenState();
}

class _AddDeviceScreenState extends State<AddDeviceScreen> {
  //global key to access the form at the sign up button
  final _formKey = GlobalKey<FormState>();

  //global key to access the scaffold at onSuccess and onFail functions
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  //controllers to get info from text fields
  final _nameController = TextEditingController();

  //device controller
  final DeviceController deviceController = DeviceController();

  //bool to see if the device has been edited
  bool _deviceEdited = false;

  int _mode;
  bool _selected = false;

  List<DropdownMenuItem> dropDownMenuItems(){
    List<DropdownMenuItem> items = [];
    Map<String, int> information = {
      'DHT11 Sensor': 0,
      'Presence Sensor': 1
    };

    information.forEach((key, value) {
      items.add(
        DropdownMenuItem<int>(
            value: value,
            child: Text(key)
        )
      );
    });

    return items;
  }

  @override
  Widget build(BuildContext context) {

    //function that executes when update is a success
    void _onSuccess(){

      //snack bar with success information
      _scaffoldKey.currentState.showSnackBar(
          SnackBar(
              content: Text('Success to add Device!'),
              backgroundColor: Theme.of(context).primaryColor,
              duration: Duration(seconds: 2)
          )
      );

      //after 2 sec goes to home screen
      Future.delayed(
          Duration(seconds:2)
      ).then((_){
        Navigator.of(context).pop();
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => HomeScreen())
        );
      });
    }

    //function that executes when update is a fail
    void _onFail(){
      //snack bar with success information
      _scaffoldKey.currentState.showSnackBar(
          SnackBar(
              content: Text('Fail to add Device!'),
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
                title: Text("Discard Device?"),
                content: Text("If you leave device will be lost."),
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
          title: Text("Add Device"),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if(_formKey.currentState.validate() && _deviceEdited) {
              //device map
              Map<String, dynamic> deviceData;

              deviceData = {
                'name': _nameController.text,
                'mode': _mode,
              };

              deviceController.addDevice(deviceData, _onSuccess, _onFail);

            }
          },
          child: Icon(Icons.add),
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
              SizedBox(height: 16.0),
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
                  DropdownButtonFormField(
                    dropdownColor: Color.fromARGB(255, 224, 224, 224),
                    decoration: InputDecoration(
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
                    elevation: 1,
                    iconSize: 30.0,
                    isExpanded: true,
                    hint: new Text("Choose the device type"),
                    value: _mode,
                    isDense: true,
                    validator: (value){ //rule to validate the input data
                      if(value == null) return 'Invalid Type!';
                      else return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _mode = value;
                        _selected = true;
                        _deviceEdited = true;
                      });
                      print("value: $_mode");
                    },
                    items: dropDownMenuItems()
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