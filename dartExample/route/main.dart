import 'package:flutter/material.dart';
import 'package:answer/navigation_home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // 使用命名导航器路由
    return new MaterialApp(
      title: 'Navigation',
      /*initialRoute: '/',
      routes: <String, WidgetBuilder> {
        '/': (BuildContext context) => new HomeNavigator()
      },*/
      home: new HomeNavigator(),
    );
  }
}

class FirstScreen extends StatelessWidget {
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('First Screen')
      ),
      body: new Center(
        child: new RaisedButton(
            child: new Text('Launch second screen'),
            onPressed: () {
              // 监听按钮按下事件，通过MaterialPageRoute创建路由，进入到新页面
              Navigator.push(
                context,
                new MaterialPageRoute(builder: (context) => new SecondScreen()),
              );
            }
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Second Screen'),
      ),
      body: new Center(
        child: new RaisedButton(
            child: new Text('Go back'),
            onPressed: (){
              Navigator.pop(context);
            }
        ),
      ),
    );
  }
}

class Article {
  String title;
  String content;
  // 设置默认参数
  Article({this.title,this.content});
}

class ArticleListScreen extends StatelessWidget {
  final List<Article> articles = new List.generate(
    10,
    (i) => new Article(
      title: 'Articl $i',
      content: 'Article $i: The quick brown fox jumps over the lazy dog.',
    ),
  );

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Article list'),
      ),
      body: new ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
            return new ListTile(
              title: new Text(articles[index].title),
              onTap: () async {
                // Navigator.push(context, new MaterialPageRoute(builder: (context) => new ContentScreen(articles[index])));
                // 路由带参数，并接受回调的参数，使用PageRouteBuilder实现一个页面旋转淡入淡出的效果。
                String result;
                // result = await Navigator.push(context, new MaterialPageRoute(builder: (context) => new ContentScreen(articles[index])));
                result = await Navigator.push(
                    context,
                    new PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 1000),
                      pageBuilder: (context, _, __) => new ContentScreen(articles[index]),
                      transitionsBuilder:
                        (_, Animation<double> animation, __, Widget child) =>
                            new FadeTransition(
                                opacity: animation,
                                child: new RotationTransition(
                                    turns: new Tween<double>(begin: 0.0, end: 1.0).animate(animation),
                                    child: child,
                                ),
                            )
                    ));
                if (result != null){
                  Scaffold.of(context).showSnackBar(
                    new SnackBar(
                        content: new Text('$result'),
                        duration: const Duration(seconds: 1),
                    ),
                  );
                }
              },
           );
        }
      ),
    );
  }
}

class ContentScreen extends StatelessWidget {
  final Article article;
  ContentScreen(this.article);
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Artical List'),
      ),
      body: new Padding(
          padding: new EdgeInsets.all(15.0),
          child: new Column(
            children: <Widget>[
              new Text('${article.content}'),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  new RaisedButton(
                      child: new Text('Like'),
                      onPressed: (){
                        Navigator.pop(context,'Like');
                      }
                  ),
                  new RaisedButton(
                      child: new Text('Unlike'),
                      onPressed: (){
                        Navigator.pop(context,'Unlike');
                      }
                  )
                ],
              )
            ],
          ),
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<PlaceholderWidget> _children = [
    new PlaceholderWidget('Home',false),
    new PlaceholderWidget('Profile',false)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: new BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          items: [
            new BottomNavigationBarItem(icon: new Icon(Icons.home),title: new Text('Home')),
            new BottomNavigationBarItem(icon: new Icon(Icons.person),title: new Text('Profile')),
          ]
      ),
    );
  }
  void onTabTapped(int index) {
      setState(() {
        _currentIndex = index;
      });
  }
}

class PlaceholderWidget extends StatelessWidget {
  final String text;
  final bool isButton;
  PlaceholderWidget(this.text,this.isButton);
  Widget genButton (BuildContext context,bool isButton){
    if (isButton){
      return new RaisedButton(
          child:new Text('clickMe')
          ,onPressed: (){
           Navigator.of(context).pushNamed('demo1');
      });
    }else{
      return new Text('$text');
    }
  }
  @override
  Widget build(BuildContext context){
    return new Center(
      child: new Column(
        children: <Widget>[
          genButton(context,isButton)
        ],
      ),
    );
  }
}


