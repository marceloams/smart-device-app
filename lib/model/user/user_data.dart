import 'package:flutter/material.dart';

class UserData {

  String name;
  String email;
  List<String> devices = [];

  void setFromMap(Map<dynamic, dynamic> m) {
    name = m['name'];
    email = m['email'];
    devices = m['devices'];
  }
}