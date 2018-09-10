import 'package:flutter/material.dart';

class MinePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _MinePageState();
  }

}

class _MinePageState extends State<MinePage> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    print("MinePageState");
    return Center(child: Text("我的"),);
  }

  @override
  bool get wantKeepAlive => true;

}