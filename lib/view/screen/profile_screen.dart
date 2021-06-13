import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multiavatar/multiavatar.dart';
import 'package:realtimedatabase_teste/controller/user_controller.dart';
import 'package:realtimedatabase_teste/model/avatar/avatar_painter.dart';
import 'package:realtimedatabase_teste/model/avatar/avatar_svg_wrapper.dart';
import 'package:realtimedatabase_teste/view/widget/afterMethodMessage.dart';

class ProfileScreen extends StatefulWidget {

  final BuildContext context;

  ProfileScreen(this.context);

  @override
  _ProfileScreenState createState() => _ProfileScreenState(context);
}

class _ProfileScreenState extends State<ProfileScreen> {

   final BuildContext c;

  _ProfileScreenState(this.c);

  //global key to access the form at the sign up button
  final _formKey = GlobalKey<FormState>();

  //global key to access the scaffold at onSuccess and onFail functions
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  //controllers to get info from text fields
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  //User Controller
  final UserController _userController = UserController();

   //create avatar profile
   String avatarSvgCode;
   DrawableRoot avatarSvgRoot;
   final _avatarController = TextEditingController();

  //bool to see if user has been edited
  bool _edited = false;
  bool _emailEdited = false;

  //to put fill the textFields
  @override
  void initState() {
    super.initState();

    _nameController.text = UserController.userData.name;
    _emailController.text = UserController.userData.email;
    _avatarController.text = UserController.userData.avatar;

    avatarSvgCode = multiavatar(_avatarController.text);

    AvatarSvgWrapper(avatarSvgCode).generateLogo().then((value) {
      setState(() {
        avatarSvgRoot = value;
      });
    });
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
            child: Icon(Icons.save),
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: (){
              if(_formKey.currentState.validate()){
                AfterMethodMessage afterMethodMessage = AfterMethodMessage(context, 'edit', 0);
                Map<String,dynamic> userMap;
                if(_emailEdited){
                  userMap = {
                    'name': _nameController.text,
                    'email': _emailController.text,
                    'avatar': _avatarController.text
                  };
                } else if(_edited){
                  userMap = {
                  'name': _nameController.text,
                  'avatar': _avatarController.text
                  };
                }
                _userController.updateUser(userMap: userMap, afterMethodMessage: afterMethodMessage);
              }
            },
          ),
          body: LayoutBuilder(
            builder: (context, constraints){
              return constraints.maxWidth < 760 ?
              Form( //to validate inputs
                key: _formKey, //global key to be accessed from 'outside'
                child: ListView(
                  padding: EdgeInsets.all(16.0),
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          child: Container(
                            height: 100.0,
                            width: 100.0,
                            child: CustomPaint(
                              painter: AvatarPainter(avatarSvgRoot, 100.0),
                              child: Container(),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                          onTap: () {
                            _edited = true;
                            var l = new List.generate(
                                12, (_) => new Random().nextInt(100));
                            _avatarController.text = l.join();
                            setState(() {
                              avatarSvgCode = multiavatar(_avatarController.text);
                            });
                            AvatarSvgWrapper(avatarSvgCode).generateSvg().then((value){
                              setState(() {
                                avatarSvgRoot = value;
                              });
                            });
                          },
                        )
                      ],
                    ),
                    SizedBox(height: 16.0),
                    TextFormField( //full name text field
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        labelStyle: TextStyle(color: Colors.black),
                        hintText: 'Name',
                      ),
                      maxLength: 20,
                      validator: (text){ //rule to validate the input data
                        if(text.isEmpty) return 'Invalid Name!';
                        else return null;
                      },
                      onChanged: (text){
                        _edited = true;
                      },
                    ),
                    TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'E-mail',
                          labelStyle: TextStyle(color: Colors.black),
                        ),
                        keyboardType: TextInputType.emailAddress, //use email keyboard type
                        validator: (text){ //rule to validate the input data
                          if(text.isEmpty || !text.contains('@')) return 'Invalid E-mail!';
                          else return null;
                        },
                        onChanged: (text){
                          _emailEdited = true;
                        }
                    ),
                    Align(
                      //to align the forgot password button
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        child: Text(
                          'Change my password',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              color: Colors.black
                          ),
                        ),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero
                        ),
                        onPressed: () {
                          if(_emailController.text.isEmpty && _emailController.text.contains('@')){ //verify if email input is empty
                            AfterMethodMessage afterMethodMessage = AfterMethodMessage(context, 'Enter your e-mail to recover your account!', 0);
                            afterMethodMessage.custom(Colors.amber, Colors.black);
                          } else {
                            _userController.recoveryPass(_emailController.text); //method to recovery email
                            AfterMethodMessage afterMethodMessage = AfterMethodMessage(context, 'Take a look in your e-mail inbox', 0);
                            afterMethodMessage.custom(Colors.blue, Colors.white);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ) :
              Center(
                child: Container(
                  width: 600,
                  child: Form( //to validate inputs
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
                            _edited = true;
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
                              _edited = true;
                            }
                        ),
                        Align(
                          //to align the forgot password button
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            child: Text(
                              'Change my password',
                              textAlign: TextAlign.right,
                            ),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          )
      ),
    );
  }

  //Alert Dialog to ask if the user wants to discard the changes
  Future<bool> _requestPop(){
    if(_edited){
      showDialog(context: context,
          builder: (context){
            return AlertDialog(
              title: Text("Discard Changes?"),
              content: Text("If you leave changes will be lost."),
              actions: <Widget>[
                TextButton(
                  child: Text(
                    "No",
                    style: TextStyle(
                        color: Colors.black
                    ),
                  ),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                ),
                TextButton(
                  child: Text(
                    "Yes",
                    style: TextStyle(
                        color: Colors.black
                    ),
                  ),
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