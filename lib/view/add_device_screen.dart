import 'package:flutter/material.dart';

import 'home_screen.dart';

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
        body: Container(),
      ),
    );
  }
}
