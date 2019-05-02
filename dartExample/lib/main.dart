import 'package:flutter/material.dart';

void main(){
  runApp(new MaterialApp(
    home: new MyButton(),
    color: Colors.pink,
  ));
}

class MyButton extends StatefulWidget {
  @override
  MyButtonState createState() {
    return new MyButtonState();
  }
}

class MyButtonState extends State<MyButton> {
  int counter = 0;
  List<String> strings = ['Flutter','is','cool','and','awesome','HaHa'];
  String displayedString = 'Hello Man';
  void onProcessButton() {
    setState((){
      displayedString = strings[counter];
      counter = counter < 5 ? counter+1 : 0;
    });
  }
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('状态性组件'),
        backgroundColor: Colors.green,
      ),
      body: new Container(
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(displayedString,style: new TextStyle(fontSize: 40.0)),
              new Padding(padding: new EdgeInsets.all(10.0)),
              new RaisedButton(
                child: new Text(
                  "press me",
                  style: new TextStyle(color: Colors.white),
                ),
                color: Colors.red,
                onPressed: onProcessButton,
              )
            ],
          ),
        ),
      ),
    );
 }
}