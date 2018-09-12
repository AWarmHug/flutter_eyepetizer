import 'package:flutter/material.dart';

class Logo extends AnimatedWidget {
  @override
  Widget build(BuildContext context) {
    Animation animation = listenable;
    return Center(
      child: FlutterLogo(
        size: animation.value,
      ),
    );
  }

  Logo({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animation = Tween(begin: 50.0, end: 100.0).animate(controller);
    controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Logo(
        animation: animation,
      ),
    );
  }
}

void main() {
  runApp(App());
}
