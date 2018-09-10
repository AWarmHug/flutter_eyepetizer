// This is a basic Flutter widget test.
// To perform an interaction with a widget in your test, use the WidgetTester utility that Flutter
// provides. For example, you can send tap and scroll gestures. You can also use WidgetTester to
// find child widgets in the widget tree, read text, and verify that the values of widget properties
// are correct.

import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/data/data_manager.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_eyepetizer/main.dart';

void main() {
  getPageData(
          "http://baobab.kaiyanapp.com/api/v5/index/tab/allRec?page=0&isTag=false")
      .then((pageData) {
    print(pageData.itemList.toString());
  });

//  getType().then((value) {
//    value.tabList.forEach((tabItem) {
//
//    });
//  });
}
