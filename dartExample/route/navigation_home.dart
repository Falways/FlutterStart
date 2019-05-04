import 'package:flutter/material.dart';
import 'package:answer/main.dart';

class HomeNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Navigator(
        initialRoute: 'home',
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          switch (settings.name) {
            case 'home':
              builder = (BuildContext context) => new HomePage();
              break;
            case 'demo1':
              builder = (BuildContext context) => new ArticleListScreen();
              break;
            default:
              throw new Exception('Invalid route: ${settings.name}');
          }
          return new MaterialPageRoute(builder: builder,settings: settings);
        },
    );
  }
}

class HomePage extends StatelessWidget{
  int _currentIndex = 0;
  final List<PlaceholderWidget> _children = [
    new PlaceholderWidget('Home',true),
    new PlaceholderWidget('Profile',false)
  ];
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Home'),
      ),
      body:  _children[_currentIndex],
      bottomNavigationBar: new BottomNavigationBar(
          onTap: (int index){
            _currentIndex = index;
            return _currentIndex;
          },
          currentIndex: _currentIndex,
          items: [
            new BottomNavigationBarItem(icon: new Icon(Icons.home),title: new Text('Home')),
            new BottomNavigationBarItem(icon: new Icon(Icons.person),title: new Text('Profile')),
          ]
      ),
    );
  }
}