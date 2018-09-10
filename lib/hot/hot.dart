import 'package:flutter/material.dart';

class HotPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _HotPageState();
  }

}

class _HotPageState extends State<HotPage> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    print("HotPageState");
    return Center(child: Text("热门"),);
  }

  @override
  bool get wantKeepAlive => true;

}