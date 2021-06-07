class DeviceExample {
  Map<dynamic,dynamic> devices;

  DeviceExample(){

    devices = {
      "123456789": {
        'id': "123456789",
        'name': "Temperature Sensor",
        'mode': 0,
        'measures': {
          "1": {
            'humidity': 60,
            'temperature': 24,
            'timestamp': "2020-12-18 23:12:01"
          },
          "2": {
            'humidity': 60,
            'temperature': 24,
            'timestamp': "2020-12-18 22:12:01"
          }
        }
      },
      "987654321": {
        'id': "987654321",
        'name': "Presence Sensor",
        'mode': 1,
        'measures': {
          "1": {
            'presence': true,
            'timestamp': "2020-12-18 23:12:01"
          },
          "2": {
            'presence': false,
            'timestamp': "2020-12-18 22:12:01"
          }
        }
      }
    };
  }



  //Measure Sensor
}