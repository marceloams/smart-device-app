import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:realtimedatabase_teste/controller/device_controller.dart';

import 'measures_tile.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DeviceController deviceController = DeviceController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Smart Home"),
          centerTitle: true,
        ),
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                child: Text("Read data"),
                onPressed: () async{
                  setState((){
                    deviceController.loadDevices().asStream();
                  });
                },
              ),
              Expanded(
                child: SizedBox(
                  height: 200.0,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: DeviceController.devices.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Container(
                          height: 150.0,
                          child: Column(
                            children: [
                              Container(
                                height: 50,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      child: Text(
                                        DeviceController.devices[index].name,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25.0,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      left: 150.0,
                                      top: 8.0
                                    ),
                                    Positioned(
                                      child: IconButton(
                                        icon: Icon(Icons.refresh),
                                        onPressed: (){},
                                      ),
                                      right: 70.0,
                                    ),
                                    Positioned(
                                      child: IconButton(
                                        icon: Icon(Icons.list_alt),
                                        onPressed: (){},
                                      ),
                                      right: 35.0,
                                    ),
                                    Positioned(
                                      child: IconButton(
                                        icon: Icon(Icons.settings),
                                        onPressed: (){},
                                      ),
                                      right: 0.0,
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: SizedBox(
                                      height: 50.0,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: DeviceController.devices[index].measures[0].measures.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index2){
                                          return MeasuresTile(DeviceController.devices[index].measures[0], index2);
                                        },
                                      ),
                                    )
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add
        ),
        onPressed: (){},
      ),
    );
  }
}