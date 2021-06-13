import 'package:flutter/material.dart';
import 'package:realtimedatabase_teste/view/screen/signIn_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

void main() {
  // check if is running on Web
  if (kIsWeb) {
    // initialize the facebook javascript SDK
    FacebookAuth.i.webInitialize(
      appId: "827295831518838",
      cookie: true,
      xfbml: true,
      version: "v9.0",
    );
  }
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.warning_amber_outlined,
                color: Colors.red,
                size: 50.0,
              ),
              Text(
                'Something went wrong!',
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.red
                ),
              )
            ],
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: 'Smart Devices',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: SignInScreen(),
            debugShowCheckedModeBanner: false,
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

