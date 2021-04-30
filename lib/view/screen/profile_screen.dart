import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:realtimedatabase_teste/view/widget/afterMethodMessage.dart';

class ProfileScreen extends StatefulWidget {

  BuildContext context;

  ProfileScreen(BuildContext context){
    this.context = context;
  }

  @override
  _ProfileScreenState createState() => _ProfileScreenState(context);
}

class _ProfileScreenState extends State<ProfileScreen> {

   BuildContext c;

  _ProfileScreenState(BuildContext context){
    this.c = context;
  }

  //global key to access the form at the sign up button
  final _formKey = GlobalKey<FormState>();

  //global key to access the scaffold at onSuccess and onFail functions
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  //controllers to get info from text fields
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  //File to save user image
  File userImg;

  //bool to see if the user has been edited
  bool _userEdited = false;

  //to put fill the textFields
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title:Text('Profile'),
            centerTitle: true,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              //create a AfterMethodMessage
              AfterMethodMessage afterMethodMessage = AfterMethodMessage(context, 'edit', 1);

              afterMethodMessage.onSuccess();
            },
            child: Icon(Icons.save),
            backgroundColor: Theme.of(context).primaryColor,
          ),
          body: Form( //to validate inputs
                key: _formKey, //global key to be accessed from 'outside'
                child: ListView(
                  padding: EdgeInsets.all(16.0),
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.person_rounded,
                          size: 72,
                        )
                      ],
                    ),
                    SizedBox(height: 16.0),
                    TextFormField( //full name text field
                      controller: _nameController,
                      //focusNode: _nameFocus,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        labelStyle: TextStyle(color: Colors.black),
                        hintText: 'Name',
                        //border: InputBorder.none,
                      ),
                      //enabled: _nameActivated, //to control input activation
                      validator: (text){ //rule to validate the input data
                        if(text.isEmpty) return 'Invalid Name!';
                        else return null;
                      },
                      onChanged: (text){
                        _userEdited = true;
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField( //email text field
                        controller: _emailController,
                        //focusNode: _emailFocus,
                        decoration: InputDecoration(
                          labelText: 'E-mail',
                          labelStyle: TextStyle(color: Colors.black),
                          //border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.emailAddress, //use email keyboard type
                        //enabled: _emailActivated,
                        validator: (text){ //rule to validate the input data
                          if(text.isEmpty || !text.contains('@')) return 'Invalid E-mail!';
                          else return null;
                        },
                        onChanged: (text){
                          _userEdited = true;
                        }
                    ),
                    Align(
                      //to align the forgot password button
                      alignment: Alignment.centerRight,
                      child: FlatButton(
                        child: Text(
                          'Change my password',
                          textAlign: TextAlign.right,
                        ),
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              )
      ),
    );
  }

  //Alert Dialog to ask if the user wants to discard the changes
  Future<bool> _requestPop(){
    if(_userEdited){
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
}