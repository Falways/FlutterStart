import 'package:flutter/material.dart';
import 'package:event_bus/event_bus.dart';
import 'dart:math' show Random;

EventBus eventBus = new EventBus();

void main() => runApp(MyApp());

// Stateless widgets 是不可变的, 这意味着它们的属性不能改变 - 所有的值都是最终的.
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title:'Best answer',
        home: new HomePage(),
    );
  }
}

class HomePage extends StatefulWidget{
 State<HomePage> createState() {
   return new _HomePage('');
 }

}

class _HomePage extends State<HomePage>{
  var openEdit = true;
  String testState;
  Map<String,String> mapS = new Map<String,String>();

  void initState() {
    super.initState();
    /*eventBus.on().listen((data) {
      print('传递过来的值：${data.testState}');
    }
    );*/
    eventBus.on<_HomePage>().listen((_HomePage data) {
      print('输出为：$data ${data.testState}');
    });
  }

  void onDataChange(val) {
    print('子组件传递来的值：$val');
    setState(() {
      openEdit = val;
    });
  }
  _HomePage(this.testState);
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Best answer'),
        centerTitle: true,
      ),
      body: new SingleChildScrollView( child: new Center(
        child: new Padding(
          padding: new EdgeInsets.only(top: 15.0),
          child: new Column(
            children: <Widget>[
              new RightFloatButton(openEdit: openEdit, callback: (openEdit) =>  onDataChange(openEdit)),
              new Offstage(
                  offstage:openEdit == true? true : false,
                  child:  _editColumn()
              ),
            ],
          ),
        )
      ),
    )
    );
  }
  Widget _editColumn() {
    final controller = TextEditingController();
    controller.addListener(() {
      mapS['content'] = controller.text;
    });
    final controller1 = TextEditingController();
    controller1.addListener(() {
      mapS['title'] = controller1.text;
    });
    // return new TextField( autofocus: true);
    return new Column(
      children: <Widget>[
        new Container(
          margin: EdgeInsets.only(left: 50.0, right: 50.0, top: 50.0),
          child: new Material(
              shape: new OutlineInputBorder(
                borderRadius: new BorderRadius.all(new Radius.circular(20.0)),
                borderSide: new BorderSide(
                    style: BorderStyle.none,
                    color: Colors.blue,
                    width: 1.0
                ),
              ),
              child: new TextField(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(1.0),
                    icon: Icon(Icons.title),
                    labelText: '标题'
                ),
                controller: controller1,

              )
          ),
        ),
        new Container(
          margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 50.0),
          child: new Material(
              shape: new OutlineInputBorder(
                borderRadius: new BorderRadius.all(new Radius.circular(20.0)),
                borderSide: new BorderSide(
                    style: BorderStyle.solid,
                    color: Colors.grey,
                    width: 1.0
                ),
              ),
              child: new TextField(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(1.0),
                    icon: Icon(Icons.cloud_circle),
                    labelText: '每一项以换行分隔',
                    labelStyle: new TextStyle(wordSpacing: 10.0),
                    border:InputBorder.none
                ),
                controller: controller,
                maxLines: 6,
              )
          ),
        ),
        new Padding(
            padding: EdgeInsets.only(top: 90.0),
            child: new RaisedButton(
                child:new Padding(
                    padding: EdgeInsets.only(left: 20.0,right: 20.0,top: 5.0,bottom: 5.0),
                    child: new Text('确定',style: new TextStyle(color: Colors.white,fontSize: 20.0))
                ), 
                color: Colors.green,
                onPressed: (){
                  // 处理结果
                  print('输出$mapS');
                  //eventBus.fire(_HomePage('测试兄弟组件传值'));
                  final random = new Random();
                  String co = mapS['content'];
                  int index = random.nextInt(co.split('\n').length);
                  Navigator.push(context, new MaterialPageRoute(builder: (context) => new ResultScreen(mapS['title'], co.split('\n')[index])));
                }
            ),
        ),
      ],
    );
  }
}

 class RightFloatButton extends StatelessWidget{
  // 接受父组件传递过来的值
  var openEdit;
  RightFloatButton({Key key, this.openEdit, this.callback}) : super(key:key);
  final callback;
  /*eventBus.on<_HomePage>().listen((data) {
  print('传递过来的值：${data.testState}');
   }
  );*/
  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new RaisedButton(
           child: new Text('编辑',style: new TextStyle(color: Colors.white)),
           color: Colors.blue,
           onPressed: onPressedEvent,
        ),
      ],
    );
  }
  // 打开编辑页面
  void onPressedEvent() {
    print(openEdit);
    if (openEdit==false){
      openEdit = true;
      callback(true);
    }else {
      openEdit = false;
      callback(false);
    }
  }
}


class ResultScreen extends StatelessWidget {
  String title;
  String content;
  ResultScreen(this.title,this.content);
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Best Result'),
        centerTitle: true,
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text('问题：', style: new TextStyle(fontSize: 30.0, color: Colors.black),),
                new Text(
                  title,
                  style: new TextStyle(fontSize: 30.0, color: Colors.black),
                ),
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text(
                    content
                ),
              ],
            ),

            new RaisedButton(
              child: new Text('返回',style: new TextStyle(color: Colors.white),),
              color: Colors.blue,
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}

