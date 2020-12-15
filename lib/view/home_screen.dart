import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:realtimedatabase_teste/controller/database_controller.dart';
import 'package:realtimedatabase_teste/controller/device_controller.dart';

class HomeScreen extends StatelessWidget {

  DatabaseController dbController = DatabaseController();

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
                onPressed: (){
                  dbController.readData();
                }
            ),
            Card(
              borderOnForeground: true,
              child: Container(
                height: 250.0,
                padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.developer_board_sharp,
                      size: 100.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Name: ',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            Text(
                              'Device-1',
                              style: TextStyle(
                                  fontSize: 20.0,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Type: ',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            Text(
                              'Dht11',
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Name: ',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            Text(
                              'Device-1',
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Name: ',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            Text(
                              'Device-1',
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                )
              ),
            )
          ],
        ),
      )
    );
  }
}