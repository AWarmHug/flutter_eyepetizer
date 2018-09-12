import 'package:flutter/material.dart';

void main() {
  runApp(LogoApp());
}

class LogoApp extends StatefulWidget {
  _LogoAppState createState() => new _LogoAppState();
}

class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    animation = new Tween(begin: 50.0, end: 300.0).animate(controller)
      ..addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
        });
      });



    controller.forward();
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (animation.value == 50.0) {
          controller.forward();
        } else {
          controller.reverse();
        }
      },
      child: new Center(
        child: new Container(
          margin: new EdgeInsets.symmetric(vertical: 10.0),
          height: animation.value,
          width: animation.value,
          child: new FlutterLogo(),
        ),
      ),
    );
  }

  dispose() {
    print("hhh");
    controller.dispose();
    super.dispose();
  }
}
