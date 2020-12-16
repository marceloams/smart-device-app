import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:realtimedatabase_teste/controller/device_controller.dart';
import 'file:///D:/Users/marce/OneDrive/Documentos/Testes/realtimedatabase_teste/lib/view/tile/devices_tile.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //Controllers
  DeviceController deviceController = DeviceController();

  //Function to load page
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => deviceController.loadDevices());
  }

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
              Expanded(
                child: SizedBox(
                  height: 200.0,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: DeviceController.devices.length,
                    itemBuilder: (context, index) {
                      return DevicesTile(DeviceController.devices[index]);
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