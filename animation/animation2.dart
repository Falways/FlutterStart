import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class AnimatedLogo extends AnimatedWidget{
  // Tween 控制样式大小变化
  static final _opacityTween = new Tween<double>(begin: 0.1, end: 1.0);
  static final _sizeTween = new Tween<double>(begin: 0.0, end: 300.0);
  AnimatedLogo({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return new Center(
      child: new Opacity(
        // 关联动画
        opacity: _opacityTween.evaluate(animation),
        child: new Container(
          margin: new EdgeInsets.symmetric(vertical: 10.0),
          // 高度大小变化动画
          height: _sizeTween.evaluate(animation),
          width: _sizeTween.evaluate(animation),
          child: new FlutterLogo(),
        ),
      ),
    );
  }
}

class LogoApp extends StatefulWidget {
  _LogoAppState createState() => new _LogoAppState();
}

class _LogoAppState extends State<LogoApp> with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  // initState初始化时候加载动画
  initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);

    animation = new CurvedAnimation(parent: controller, curve: Curves.easeIn);

    // forward方法让动画开始执行
    // addStatusListener获取动画执行status
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });

    controller.forward();
  }

  // 页面的原始组件
  Widget build(BuildContext context) {
    return new AnimatedLogo(animation: animation);
  }

  // 动画完成时释放控制器(调用dispose()方法)以防止内存泄漏
  dispose() {
    controller.dispose();
    super.dispose();
  }
}

void main() {
  runApp(new LogoApp());
}