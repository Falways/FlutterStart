import 'package:flutter/material.dart';

class SecondTab extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.green,
      body: new Container(
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Icon(
                Icons.adb,
                color: Colors.white,
                size: 160.0
              ),
              new Text(
                'Second Tab',
                style: new TextStyle(
                  color: Colors.white
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}