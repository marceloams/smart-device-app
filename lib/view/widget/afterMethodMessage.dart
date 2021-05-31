import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:realtimedatabase_teste/view/screen/home_screen.dart';

class AfterMethodMessage {

  BuildContext _context;
  String _methodMessage;
  int _numberOfPops;

  AfterMethodMessage(this._context, this._methodMessage, this._numberOfPops); //function that executes when update is a success

  void onSuccess(){

    ScaffoldMessenger.of(_context).showSnackBar(
        SnackBar(
            content: Text('Success to $_methodMessage!'),
            backgroundColor: Theme.of(_context).primaryColor,
            duration: Duration(seconds: 2)
        )
    );

    //after 2 sec goes to home screen
    Future.delayed(
        Duration(seconds:2)
    ).then((_){
      _doNavigatorPop();
      Navigator.of(_context).push(
          MaterialPageRoute(builder: (_context) => HomeScreen())
      );
    });
  }

  void onFail(){
    //snack bar with failure information
    ScaffoldMessenger.of(_context).showSnackBar(
        SnackBar(
            content: Text('Fail to  $_methodMessage!'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2)
        )
    );
  }

  void custom(Color bgColor, Color fontColor){
    //snack bar with failure information
    ScaffoldMessenger.of(_context).showSnackBar(
        SnackBar(
            content: Text(
              '$_methodMessage',
              style: TextStyle(
                color: fontColor
              ),
            ),
            backgroundColor: bgColor,

            duration: Duration(seconds: 2)
        )
    );
  }

  void _doNavigatorPop(){
    for(int i=0;i<_numberOfPops;i++){
      Navigator.of(_context).pop();
    }
  }

}