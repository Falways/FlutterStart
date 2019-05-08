import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class OpacityAniWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _OpacityAniWidgetState();
  }
}

class _OpacityAniWidgetState extends State<OpacityAniWidget> with TickerProviderStateMixin {
  AnimationController _controller;

  Animation<double> opacity;

  void _initController() {
    _controller = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    );
  }

  void _initAni() {
    opacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.0,
          0.5,
          curve: Curves.easeIn,
        ),
      ),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((AnimationStatus status) {
        print(status);
      });
  }

  Future _startAnimation() async {
    try {
      await _controller.repeat();
//
//      await _controller
//          .forward()
//          .orCancel;
//      await _controller
//          .reverse()
//          .orCancel;
    } on TickerCanceled {
      print('Animation Failed');
    }
  }

  @override
  void initState() {
    super.initState();
    _initController();
    _initAni();
    _startAnimation();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Opacity(
      opacity: opacity.value,
      child: new Container(
        color: Colors.red,
        height: 200.0,
        width: 200.0,
        child: new Center(
          child: new Text(
            'opacity',
            style: new TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ),
      ),
    );
  }
}

class AnimationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _AnimationPageState();
  }
}

class _AnimationPageState extends State<AnimationPage>
    with TickerProviderStateMixin {
  int _aniIndex = 0;

  Widget _buildAnimation() {
    Widget widget;
    new OpacityAniWidget();
    return widget;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Animation"),
        centerTitle: true,
      ),
      body: new Column(
        children: <Widget>[
          new Row(
            children: <Widget>[
              new Padding(
                padding:
                const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
                child: new RaisedButton(
                    textColor: Colors.black,
                    child: new Text('opacity'),
                    onPressed: () {
                      setState(() {
                        _aniIndex = 0;
                      });
                    }),
              ),
              new Padding(
                padding:
                const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
                child: new RaisedButton(
                    textColor: Colors.black,
                    child: new Text('movement'),
                    onPressed: () {
                      setState(() {
                        _aniIndex = 1;
                      });
                    }),
              ),
              new Padding(
                padding:
                const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
                child: new RaisedButton(
                    textColor: Colors.black,
                    child: new Text('radius'),
                    onPressed: () {
                      setState(() {
                        _aniIndex = 2;
                      });
                    }),
              ),
            ],
          ),
          new Row(
            children: <Widget>[
              new Padding(
                padding:
                const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
                child: new RaisedButton(
                    textColor: Colors.black,
                    child: new Text('color'),
                    onPressed: () {
                      setState(() {
                        _aniIndex = 3;
                      });
                    }),
              ),
              new Padding(
                padding:
                const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
                child: new RaisedButton(
                    textColor: Colors.black,
                    child: new Text('rotate'),
                    onPressed: () {
                      setState(() {
                        _aniIndex = 4;
                      });
                    }),
              ),
              new Padding(
                padding:
                const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
                child: new RaisedButton(
                    textColor: Colors.black,
                    child: new Text('deform'),
                    onPressed: () {
                      setState(() {
                        _aniIndex = 5;
                      });
                    }),
              ),
            ],
          ),
          new Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Padding(
                padding:
                const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
                child: new RaisedButton(
                    textColor: Colors.black,
                    child: new Text('Staggered'),
                    onPressed: () {
                      setState(() {
                        _aniIndex = 6;
                      });
                    }),
              ),
            ],
          ),
          new Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
            child: _buildAnimation(),
          ),
        ],
      ),
    );
  }
}
void main() {
  runApp(new AnimationPage());
}