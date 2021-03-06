import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/data/bean/page_data.dart';
import 'package:flutter_eyepetizer/data/bean/tab.dart';
import 'package:flutter_eyepetizer/data/data_manager.dart';

class MainPageItem extends StatefulWidget {
  TabItem tabItem;

  MainPageItem(this.tabItem);

  @override
  State<StatefulWidget> createState() => _MainPageItemState();
}

class _MainPageItemState extends State<MainPageItem> {
  PageData pageData;
  bool loading=false;

  @override
  void initState() {
    super.initState();
    if (widget.tabItem != null) {
      load(widget.tabItem.apiUrl);
    }
  }

  void load(String url) {
    if(loading){
      return;
    }
    loading=true;
    getPageData(url).then((pageData) {
      setState(() {
        if (this.pageData == null) {
          this.pageData = pageData;
        } else {
          this.pageData += pageData;
        }
      });
      loading=false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (pageData == null || pageData.itemList == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return ListView.builder(
        itemCount: pageData.itemList.length,
        itemBuilder: (BuildContext context, int position) {
          if (position == pageData.itemList.length - 1) {
            load(pageData.nextPageUrl);
          }
          return pageData.itemList[position].getWidget(context);
        },
      );
    }
  }
}
