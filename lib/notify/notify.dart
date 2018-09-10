import 'package:flutter/material.dart';

class NotifyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NotifyPageState();
  }
}

class _NotifyPageState extends State<NotifyPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    print("NotifyPageState");
    return Center(
      child: Text("通知"),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
