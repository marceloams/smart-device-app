import 'package:flutter/material.dart';

class RequestPopAlert{

  BuildContext _context;
  bool _edited;
  String _actionMessage;

  RequestPopAlert(this._context, this._edited, this._actionMessage);

  set edited(bool value) {
    _edited = value;
  }

  Future<bool> getRequestPopAlert(){
    if(_edited){
      showDialog(context: _context,
          builder: (context){
            return AlertDialog(
              title: Text("Discard $_actionMessage?"),
              content: Text("If you leave $_actionMessage will be lost."),
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
}