import 'package:flutter/material.dart';

class AddDeviceScreen extends StatelessWidget {

  //global key to access the form at the sign up button
  final _formKey = GlobalKey<FormState>();

  //global key to access the scaffold at onSuccess and onFail functions
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  //controllers to get info from text fields
  final _nameController = TextEditingController();

  //bool to see if the device has been edited
  bool _deviceEdited = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){},
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Add Device"),
          centerTitle: true,
        ),
        body: Container(),
      ),
    );
  }
}
