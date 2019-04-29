import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(new MyApp());

// pubspec文件管理Flutter应用程序的assets(资源，如图片、package等)。 在pubspec.yaml中，将english_words（3.1.0或更高版本）添加到依赖项列表，如下面高亮显示的行：
class MyApp extends StatelessWidget {
  @override //重写
  Widget build(BuildContext context) {
    // final wordPair = new WordPair.random();
    return new MaterialApp(
      title: 'Welcome to Flutter',
      theme: new ThemeData(
        primaryColor: Colors.white
      ),
      home: new RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  createState() => new RandomWordsState();

}

class RandomWordsState extends State<RandomWords> {
  // 定义数组保存单词, (dart语言中下换线开头，会强制使其变为私有的)
  final _suggestions = <WordPair>[];
  // 定义变量定义字体的大小
  final _biggerFont = const TextStyle(fontSize: 18.0);
  // 创建set集合（储层用户收藏的单词对）,set不允许重复的值
  final _saved = new Set<WordPair>();
  Widget _buildSuggestions () {

    return new ListView.builder(
        padding: const EdgeInsets.all(16.0),
        // 对于每个建议的单词对都会调用一次itemBuilder，然后将单词对添加到ListTile行中
        // 在偶数行，该函数会为单词对添加一个ListTile row.
        // 在奇数行，该函数会添加一个分割线widget，来分隔相邻的词对。
        // 注意，在小屏幕上，分割线看起来可能比较吃力。
        itemBuilder: (context,i) {
          if (i.isOdd) return new Divider();
          // 语法 "i ~/2"，表示i除以2, 返回值是整形（向下取整），比如i为：1, 2, 3, 4, 5时
          // 结果为: 0, 1, 1, 2, 2
          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            // ...接着再生成10个单词对，然后添加到建议列表
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        }
    );
  }
  // 对于每一个单词对，_buildSuggestions函数都会调用一次_buildRow。 这个函数在ListTile中显示每个新词对，这使您在下一步中可以生成更漂亮的显示行
  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: (){
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          }else {
            _saved.add(pair);
          }
        });
      },
    );
  }

 /* Ctrl + Shift + / 多行注释快捷键
  当用户点击导航栏中的列表图标时，建立一个路由并将其推入到导航管理器栈中。此操作会切换页面以显示新路由。
  新页面的内容在在MaterialPageRoute的builder属性中构建，builder是一个匿名函数。
  添加Navigator.push调用，这会使路由入栈（以后路由入栈均指推入到导航管理器的栈）*/
  void _pushSaved(){
    Navigator.of(context).push(
      new MaterialPageRoute(
          builder: (context) {
            final tiles = _saved.map((pair) {
              return new ListTile(
                title: new Text(
                    pair.asPascalCase,
                    style: _biggerFont,
                ),
              );
            });
            final divided = ListTile.divideTiles(
              context: context,
              tiles: tiles
            ).toList();
            // builder返回一个Scaffold，其中包含名为“Saved Suggestions”的新路由的应用栏。
            // 新路由的body由包含ListTiles行的ListView组成; 每行之间通过一个分隔线分隔
            return new Scaffold(
              appBar: new AppBar(
                title: new Text('Saved Suggestions'),
              ),
              body: new ListView(children: divided),
            );
      },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Startup Name Generator'),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list), onPressed: _pushSaved)
        ],
      ),
      body: _buildSuggestions(),
    );
  }
}