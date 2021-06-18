import 'package:flutter/material.dart';
import 'package:realtimedatabase_teste/model/device/device_data.dart';
import 'package:realtimedatabase_teste/view/screen/device_log_screen.dart';
import 'package:realtimedatabase_teste/view/screen/device_settings_screen.dart';
import 'package:realtimedatabase_teste/view/tile/measures_tile.dart';
import 'package:realtimedatabase_teste/view/widget/measures_table.dart';

class DevicesTile extends StatelessWidget {

  final DeviceData deviceData;

  final displaySize;

  DevicesTile(this.deviceData, this.displaySize);

  @override
  Widget build(BuildContext context) {
    MeasuresTable measuresTable = MeasuresTable(deviceData);
    return Card(
      child: Container(
        height: displaySize > 760 ? 200.0 : 150.0,
        width: 500.0,
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
                      left: displaySize < 760 ? 0.0 : 15.0,
                      top: 12.5
                  ),
                  displaySize < 760 ?
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
                  ) : Container(),
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
            displaySize > 760 ? Divider(color: Colors.black) : Container(),
            SizedBox(height: 16.0),
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
            displaySize > 760 ?
            Column(
              children: [
                SizedBox(height: 16.0),
                Divider(color: Colors.black),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Text(
                        "Measures",
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 25.0
                        ),
                        textAlign: TextAlign.left,
                      ),
                    )
                  ],
                )
              ],
            ) : Container(),
            displaySize > 760 ?
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(16.0),
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    measuresTable.getDataTable()
                  ],
                ),
              ),
            ) : Container()
          ],
        ),
      ),
    );
  }
}
