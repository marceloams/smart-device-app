import 'package:auth_buttons/auth_buttons.dart' show GoogleAuthButton, FacebookAuthButton;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:realtimedatabase_teste/controller/user_controller.dart';
import 'package:realtimedatabase_teste/view/screen/home_screen.dart';
import 'package:realtimedatabase_teste/view/widget/afterMethodMessage.dart';
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

  //user controller
  final UserController _userController = UserController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User user) async {
      if (user != null) {
        await _userController.loadUser(user);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        key: _scaffoldKey,
        body: LayoutBuilder(
          builder: (context, constraints){
            return constraints.maxWidth < 760 ?
            Form(
              //to validate inputs
              key: _formKey, //global key to be accessed from 'outside'
              child: ListView(
                padding: EdgeInsets.all(16.0),
                children: <Widget>[
                  SizedBox(height: 32.0),
                  Text(
                    'Smart Devices',
                    style: TextStyle(
                        fontSize: 40.0
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.0),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.black
                          ),
                        ),
                        onPressed: (){
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (_context) => SignUpScreen())
                          );
                        },
                      ),
                      TextButton(
                        child: Text(
                          'Forgot my password',
                          style: TextStyle(
                              color: Colors.black
                          ),
                        ),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                        ),
                        onPressed: () {
                          if(_emailController.text.isEmpty || !_emailController.text.contains('@')){ //verify if email input is empty
                            AfterMethodMessage afterMethodMessage = AfterMethodMessage(context, 'Enter your e-mail to recover your account!', 0);
                            afterMethodMessage.custom(Colors.amber, Colors.black);
                          } else {
                            _userController.recoveryPass(_emailController.text); //method to recovery email
                            AfterMethodMessage afterMethodMessage = AfterMethodMessage(context, 'Take a look in your e-mail inbox', 0);
                            afterMethodMessage.custom(Colors.blue, Colors.white);
                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  SizedBox(
                    height: 50.0,
                    child: ElevatedButton(
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                      ),
                      onPressed: () {
                        if(_formKey.currentState.validate()){
                          // Navigator.of(context).pushReplacement(
                          //     MaterialPageRoute(builder: (context) => HomeScreen()));
                          setState(() {
                            //create a AfterMethodMessage
                            AfterMethodMessage afterMethodMessage = AfterMethodMessage(context, 'sign in', 1);
                            _userController.signInEmail(_emailController.text, _passController.text, afterMethodMessage);
                          });
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 16.0),
                  SizedBox(
                    height: 50.0,
                    child: GoogleAuthButton(
                        onPressed: () {
                          //create a AfterMethodMessage
                          AfterMethodMessage afterMethodMessage = AfterMethodMessage(context, 'sign in', 1);
                          _userController.signInGoogle(afterMethodMessage);
                        },
                        darkMode: false
                    ),
                  ),
                  SizedBox(height: 16.0),
                  SizedBox(
                    height: 50.0,
                    child: FacebookAuthButton(
                        onPressed: () {
                          //create a AfterMethodMessage
                          AfterMethodMessage afterMethodMessage = AfterMethodMessage(context, 'sign in', 1);
                          _userController.signInFacebook(afterMethodMessage);
                        },
                        darkMode: false
                    ),
                  )
                ],
              ),
            ) :
            Center(
              child: Container(
                width: 600,
                child: Form(
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
                        child: TextButton(
                          child: Text(
                            'Forgot my password',
                            textAlign: TextAlign.right,
                          ),
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero
                          ),
                          onPressed: () {
                            if(_emailController.text.isEmpty){ //verify if email input is empty
                              AfterMethodMessage afterMethodMessage = AfterMethodMessage(context, 'Enter your e-mail to recover your account!', 0);
                              afterMethodMessage.custom(Colors.amber, Colors.black);
                            } else {
                              _userController.recoveryPass(_emailController.text); //method to recovery email
                              AfterMethodMessage afterMethodMessage = AfterMethodMessage(context, 'Take a look in your e-mail inbox!', 0);
                              afterMethodMessage.custom(Colors.green, Colors.white);
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 16.0),
                      SizedBox(
                        height: 44.0,
                        child: ElevatedButton(
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)
                            ),
                          ),
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
                ),
              ),
            );
          },
        )
    );
  }
}