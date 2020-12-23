import 'package:flutter/material.dart';
import 'package:realtimedatabase_teste/model/device/device_data.dart';
import 'package:realtimedatabase_teste/view/screen/device_log_screen.dart';
import 'package:realtimedatabase_teste/view/screen/device_settings_screen.dart';
import 'package:realtimedatabase_teste/view/tile/measures_tile.dart';

class DevicesTile extends StatelessWidget {

  final DeviceData deviceData;

  DevicesTile(this.deviceData);

  @override
  Widget build(BuildContext context) {
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
                        deviceData.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      left: 0.0,
                      top: 8.0
                  ),
                  Positioned(
                    child: IconButton(
                      icon: Icon(Icons.list_alt),
                      onPressed: (){
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context)=>DeviceLogScreen(deviceData))
                        );
                      },
                    ),
                    right: 35.0,
                  ),
                  Positioned(
                    child: IconButton(
                      icon: Icon(Icons.settings),
                      onPressed: (){
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context)=>DeviceSettingsScreen(deviceData))
                        );
                      },
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
                      itemCount: deviceData.measures[0].measures.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index){
                        return MeasuresTile(deviceData.measures.first, index);
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
  }
}
