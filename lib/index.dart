import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/detail/detail.dart';
import 'package:flutter_eyepetizer/hot/hot.dart';
import 'package:flutter_eyepetizer/main/main.dart';
import 'package:flutter_eyepetizer/mine/mine.dart';
import 'package:flutter_eyepetizer/notify/notify.dart';
import 'utils/app_icons.dart';

class NavigationIconView {
  final BottomNavigationBarItem item;
  final AnimationController controller;

  NavigationIconView(Widget icon, Widget title, TickerProvider vsync)
      : item = BottomNavigationBarItem(icon: icon, title: title),
        controller = AnimationController(
            duration: kThemeAnimationDuration, vsync: vsync);
}

class IndexApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _IndexAppState();
  }
}

class _IndexAppState extends State<IndexApp>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin<IndexApp> {
  int _currentIndex = 0;
  List<NavigationIconView> _navigationIconViews;
  List<StatefulWidget> _pages;

  @override
  void initState() {
    super.initState();
    print("_IndexAppState");
    _navigationIconViews = [
      NavigationIconView(Icon(AppIcons.main, size: 24.0),
          Text("主页", style: TextStyle(fontSize: 14.0)), this),
      NavigationIconView(Icon(AppIcons.hot, size: 24.0),
          Text("热门", style: TextStyle(fontSize: 14.0)), this),
      NavigationIconView(Icon(AppIcons.notify, size: 24.0),
          Text("通知", style: TextStyle(fontSize: 14.0)), this),
      NavigationIconView(Icon(AppIcons.mine, size: 24.0),
          Text("我的", style: TextStyle(fontSize: 14.0)), this)
    ];
    _pages = [
      MainPage(),
      HotPage(),
      NotifyPage(),
      MinePage(),
    ];
    _navigationIconViews.forEach((view) {
      view.controller.addListener(_rebuild);
    });
  }

  void _rebuild() {
    setState(() {});
  }

  @override
  void dispose() {
    _navigationIconViews.forEach((view) {
      view.controller.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {"video_detail":(context){
        return VideoDetailPage();
      }},
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.white,
        accentColor: Colors.black,
      ),
      home: Scaffold(
        body: Center(
          child: _pages[_currentIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: _navigationIconViews
              .map((navigationIconViews) => navigationIconViews.item)
              .toList(),
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          fixedColor: Colors.black,
          onTap: (index) {
            setState(() {
              _navigationIconViews[_currentIndex].controller.reverse();
              _currentIndex = index;
              _navigationIconViews[_currentIndex].controller.forward();
            });
          },
        ),
      ),
    );
  }

  // TODO: implement wantKeepAlive
  @override
  bool get wantKeepAlive => true;
}
