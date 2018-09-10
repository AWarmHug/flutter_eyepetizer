import 'dart:async';

import 'package:http/http.dart';

import 'bean/base.dart';
import 'bean/tab.dart';
import 'bean/page_data.dart';

const int code_unknown = 10000;

typedef void OnSuccess<T>(T t);

typedef void OnFail(HttpError error);

Map<String, String> _default = {"user-agent": "illegal-app"};

Future<TabInfoBean> getType({OnFail onFail(HttpError error)}) async {
  String dataURL =
      "http://baobab.kaiyanapp.com/api/v5/index/tab/list?udid=d24d0fa723e4450cb436e27d28e7dcebd350141b";
  Response response = await get(dataURL, headers: _default);
  if (response.statusCode == 200) {
    if (response.body != null) {
      return TabInfo.fromJson(response.body).tabInfo;
    }
  } else {
    onFail(HttpError(code_unknown, "网络请求失败"));
  }
}

Future<PageData> getPageData(String url,
    {OnFail onFail(HttpError error)}) async {
  if (url.contains("?")) {
    url += "&udid=d24d0fa723e4450cb436e27d28e7dcebd350141b";
  } else {
    url += "?udid=d24d0fa723e4450cb436e27d28e7dcebd350141b";
  }
  print(url);
  Response response = await get(url, headers: _default);
  if (response.statusCode == 200) {
    if (response.body != null) {
      return PageData.fromJson(response.body);
    }
  } else {
    if (onFail != null) {
      onFail(HttpError(code_unknown, "网络请求失败"));
    }
  }
}

