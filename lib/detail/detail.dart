import 'package:flutter/material.dart';

class VideoDetailPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _VideoDetailState();
  }
}

class _VideoDetailState extends State<VideoDetailPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text("详情"),
        ),
      ),
    );
  }
}

class ImageDetailPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
  }

}

class _ImageDetailState extends State<ImageDetailPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
  }
}
