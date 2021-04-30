import 'package:flutter/material.dart';
import 'package:realtimedatabase_teste/view/screen/signIn_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  MyApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Devices',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignInScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
