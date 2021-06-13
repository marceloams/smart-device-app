import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multiavatar/multiavatar.dart';
import 'package:realtimedatabase_teste/controller/user_controller.dart';
import 'package:realtimedatabase_teste/model/avatar/avatar_painter.dart';
import 'package:realtimedatabase_teste/model/avatar/avatar_svg_wrapper.dart';
import 'package:realtimedatabase_teste/view/widget/afterMethodMessage.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  //global key to access the form at the sign up button
  final _formKey = GlobalKey<FormState>();

  //global key to access the scaffold at onSuccess and onFail functions
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  //controllers to get info from text fields
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  //controller to validate
  final _pass2Controller = TextEditingController();

  //user controller
  final UserController userController = UserController();

  //create avatar profile
  String avatarSvgCode = multiavatar('X-SLAYER');
  DrawableRoot avatarSvgRoot;
  final _avatarController = TextEditingController();

  @override
  void initState() {
    super.initState();
    AvatarSvgWrapper(avatarSvgCode).generateLogo().then((value) {
      setState(() {
        avatarSvgRoot = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title:Text('Sign Up'),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {

            Map<String, dynamic> userMap = {
              'name': _nameController.text,
              'email': _emailController.text,
              'avatar': _avatarController.text
            };

            AfterMethodMessage afterMethodMessage = AfterMethodMessage(context, 'Sign Up', 0);

            if (_formKey.currentState.validate()) {
              userController.signUpEmail(userMap: userMap, pass: _passController.text, afterMethodMessage: afterMethodMessage);
            }
          },
          child: Icon(Icons.save),
          backgroundColor: Theme.of(context).primaryColor,
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
                  TextFormField( //full name text field
                      controller: _nameController,
                      decoration: InputDecoration(
                          hintText: 'Name'
                      ),
                      keyboardType: TextInputType.emailAddress, //use email keyboard type
                      validator: (text){ //rule to validate the input data
                        if(text.isEmpty) return 'Invalid Name!';
                        else return null;
                      },
                      maxLength: 20
                  ),
                  TextFormField( //email text field
                    controller: _emailController,
                    decoration: InputDecoration(
                        hintText: 'E-mail'
                    ),
                    keyboardType: TextInputType.emailAddress, //use email keyboard type
                    validator: (text){ //rule to validate the input data
                      if(text.isEmpty || !text.contains('@')) return 'Invalid E-mail!';
                      else return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField( //password text field
                    controller: _passController,
                    decoration: InputDecoration(
                        hintText: 'Password'
                    ),
                    obscureText: true, //to hide elements
                    validator: (text){ //rule to validate the input data
                      if(text.length<8 || text.isEmpty){
                        return 'Invalid Password! (Must have 8 or more characters)';
                      } else return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField( //password confirmation text field
                    controller: _pass2Controller,
                    decoration: InputDecoration(
                        hintText: 'Confirm Password'
                    ),
                    obscureText: true, //to hide elements
                    validator: (text){ //rule to validate the input data
                      if(_pass2Controller.text !=_passController.text){
                        return 'Invalid Password! (Passwords must be the same)';
                      } else return null;
                    },
                  ),
                  SizedBox(height: 16.0)
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
                      TextFormField( //full name text field
                          controller: _nameController,
                          decoration: InputDecoration(
                              hintText: 'Name'
                          ),
                          keyboardType: TextInputType.emailAddress, //use email keyboard type
                          validator: (text){ //rule to validate the input data
                            if(text.isEmpty) return 'Invalid Name!';
                            else return null;
                          },
                          maxLength: 20
                      ),
                      TextFormField( //email text field
                        controller: _emailController,
                        decoration: InputDecoration(
                            hintText: 'E-mail'
                        ),
                        keyboardType: TextInputType.emailAddress, //use email keyboard type
                        validator: (text){ //rule to validate the input data
                          if(text.isEmpty || !text.contains('@')) return 'Invalid E-mail!';
                          else return null;
                        },
                      ),
                      SizedBox(height: 16.0),
                      TextFormField( //password text field
                        controller: _passController,
                        decoration: InputDecoration(
                            hintText: 'Password'
                        ),
                        obscureText: true, //to hide elements
                        validator: (text){ //rule to validate the input data
                          if(text.length<8 || text.isEmpty){
                            return 'Invalid Password! (Must have 8 or more characters)';
                          } else return null;
                        },
                      ),
                      SizedBox(height: 16.0),
                      TextFormField( //password confirmation text field
                        controller: _pass2Controller,
                        decoration: InputDecoration(
                            hintText: 'Confirm Password'
                        ),
                        obscureText: true, //to hide elements
                        validator: (text){ //rule to validate the input data
                          if(_pass2Controller.text !=_passController.text){
                            return 'Invalid Password! (Passwords must be the same)';
                          } else return null;
                        },
                      ),
                      SizedBox(height: 16.0)
                    ],
                  ),
                ),
              ),
            );
          },
        )
    );
  }
}