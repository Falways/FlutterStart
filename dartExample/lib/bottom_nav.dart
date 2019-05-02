import 'package:flutter/material.dart';
import 'package:study430/tabs/first.dart';
import 'package:study430/tabs/second.dart';
import 'package:study430/tabs/third.dart';

void main(){
  runApp(new MaterialApp(
    title: "Using Tabs",
    home: new MyHome()
  ));
}

class MyHome extends StatefulWidget{
  MyHomeState createState() => new MyHomeState();
}

class MyHomeState extends State<MyHome> with SingleTickerProviderStateMixin {
  // Create a tab controller
  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = new TabController(length: 3, vsync: this);
  }

  @override
  void dispose(){
    // 处理切换选项卡
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("选项卡切换菜单"),
        backgroundColor: Colors.brown,
      ),
      body: new TabBarView(
        children: <Widget>[new FirstTab(),new SecondTab(),new ThirdTab()],
        controller: controller,
      ),
      bottomNavigationBar: new Material(
        color: Colors.blue,
        child: new TabBar(
            tabs: <Tab>[
             new Tab(
               icon:new Icon(Icons.favorite),
               text: 'a',
             ),
             new Tab(
               icon:new Icon(Icons.adb),
               text: 'b',
             ),
             new Tab(
               icon:new Icon(Icons.airport_shuttle),
               text: 'c',
             )
            ],
            controller: controller,
        )
      ),
    );
  }

}