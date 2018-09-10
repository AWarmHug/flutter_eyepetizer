import 'package:flutter/material.dart';
import 'main_page_item.dart';
import 'package:flutter_eyepetizer/data/data_manager.dart';
import 'package:flutter_eyepetizer/data/bean/tab.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainPageState();
  }
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin<MainPage> {
  List<TabItem> tabs = [];
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: tabs.length, vsync: this);
    if (tabs.isEmpty) {
      getType().then((tabInfoBean) {
        setState(() {
          tabs = tabInfoBean.tabList;
          _tabController =
              TabController(length: tabs.length, vsync: this);
        });
      });
    }
  }

  @override
  void dispose() {
//    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Expanded(
              child: tabs.isEmpty
                  ? LinearProgressIndicator()
                  : TabBar(
                      controller: _tabController,
                      tabs: tabs.map((tab) {
                        return Tab(
                          child: Text(
                            tab.name,
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                        );
                      }).toList(),
                      labelColor: Colors.black,
                      isScrollable: true,
                    ),
            ),
            IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                onPressed: () {})
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: tabs.map((tabItem) {
          return MainPageItem(tabItem);
        }).toList(),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
