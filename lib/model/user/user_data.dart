class UserData {

  String id;
  String name;
  String email;
  String avatar;
  List<String> devices = [];

  void setFromMap(Map<dynamic, dynamic> m) {
    id = m['id'];
    name = m['name'];
    email = m['email'];
    avatar = m['avatar'];
    devices = m['devices'];
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