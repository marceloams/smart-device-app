import 'package:auth_buttons/auth_buttons.dart' show GoogleAuthButton, FacebookAuthButton;
import 'package:flutter/material.dart';
import 'package:realtimedatabase_teste/view/screen/home_screen.dart';

import 'signUp_screen.dart';


class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  //global key to access the form at the log in button
  final _formKey = GlobalKey<FormState>();

  //global key to access the scaffold at onSuccess and onFail functions
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  //controllers to get info from text fields
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title:Text('Smart Devices'),
          centerTitle: true,
          actions: <Widget>[
            FlatButton(
              child: Text(
                'SIGN UP',
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
              textColor: Colors.white,
              onPressed: (){
                // Navigator.of(context).pushReplacement(
                //     MaterialPageRoute(
                //         builder: (context)=>SignUpScreen()
                //     )
                // );
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_context) => SignUpScreen())
                );
              },
            )
          ],
        ),
        body: Form(
          //to validate inputs
          key: _formKey, //global key to be accessed from 'outside'
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: <Widget>[
              Image.asset(
                'assets/images/app_icon.png',
                height: 128,
              ),
              SizedBox(height: 16.0),
              TextFormField(
                //email text field
                controller: _emailController,
                decoration: InputDecoration(hintText: 'E-mail'),
                keyboardType: TextInputType.emailAddress,
                //use email keyboard type
                validator: (text) {
                  //rule to validate the input data
                  if (text.isEmpty || !text.contains('@'))
                    return 'Invalid E-mail!';
                  else
                    return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                //password text field
                controller: _passController,
                decoration: InputDecoration(hintText: 'Password'),
                obscureText: true, //to hide elements
                validator: (text) {
                  //rule to validate the input data
                  if (text.length < 8 || text.isEmpty)
                    return 'Invalid Password (Must have 8 or more characters)';
                  else
                    return null;
                },
              ),
              Align(
                //to align the forgot password button
                alignment: Alignment.centerRight,
                child: FlatButton(
                  child: Text(
                    'Forgot my password',
                    textAlign: TextAlign.right,
                  ),
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                ),
              ),
              SizedBox(height: 16.0),
              SizedBox(
                height: 44.0,
                child: RaisedButton(
                  child: Text(
                    'Sign In',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  textColor: Colors.white,
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                ),
              ),
              SizedBox(height: 16.0),
              SizedBox(
                height: 44.0,
                child: GoogleAuthButton(
                    onPressed: () {}, darkMode: false),
              ),
              SizedBox(height: 16.0),
              SizedBox(
                height: 44.0,
                child: FacebookAuthButton(
                    onPressed: () {}, darkMode: false),
              )
            ],
          ),
        )
    );
  }
}