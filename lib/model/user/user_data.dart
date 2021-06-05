import 'package:flutter/cupertino.dart';

class UserData {

  String id;
  String name;
  String email;
  String avatar;
  List<String> devices = [];

  void setFromMap(Map<dynamic, dynamic> m) {
    if(m['id'] != null) id = m['id'];
    if(m['name'] != null) name = m['name'];
    if(m['email'] != null) email = m['email'];
    if(m['avatar'] != null) avatar = m['avatar'];
    if(m['devices'] != null) devices = m['devices'];
  }

  Map<dynamic, dynamic> getAsMap (){
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatar': avatar,
      'devices': devices
    };
  }
}