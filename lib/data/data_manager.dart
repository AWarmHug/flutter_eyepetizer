import 'dart:async';

import 'package:http/http.dart';

import 'bean/base.dart';
import 'bean/tab.dart';
import 'bean/page_data.dart';

const int code_unknown = 10000;

typedef void OnSuccess<T>(T t);

typedef void OnFail(HttpError error);

Map<String, String> _default = {"user-agent": "illegal-app"};

String defaultParameter="&vc=395&vn=4.4.2&deviceModel=MI%208&first_channel=eyepetizer_xiaomi_market&last_channel=eyepetizer_xiaomi_market&system_version_code=27";

Future<TabInfoBean> getType({OnFail onFail(HttpError error)}) async {
  String url =
      "http://baobab.kaiyanapp.com/api/v5/index/tab/list?udid=d24d0fa723e4450cb436e27d28e7dcebd350141b"+defaultParameter;
  Response response = await get(url, headers: _default);
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
  url+=defaultParameter;
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
//http://baobab.kaiyanapp.com/api/v4/video/related?id=56182&udid=08eda8e6ceb44c7387c7cdb5db781a7c3ae1dd8a

Future<List<ContentItem>> getVideoRelated(int id) async {
  String url =
      "http://baobab.kaiyanapp.com/api/v4/video/related?id=$id&udid=08eda8e6ceb44c7387c7cdb5db781a7c3ae1dd8a"+defaultParameter;

  Response response = await get(url, headers: _default);
  if (response.statusCode == 200) {
    if (response.body != null) {
      return PageData.fromJson(response.body).itemList;
    }
  } else {}
}

//http://baobab.kaiyanapp.com/api/v2/replies/video?videoId=120654&udid=08eda8e6ceb44c7387c7cdb5db781a7c3ae1dd8a&vc=395&vn=4.4.2&deviceModel=MI%208&first_channel=eyepetizer_xiaomi_market&last_channel=eyepetizer_xiaomi_market&system_version_code=27

//http://baobab.kaiyanapp.com/api/v2/replies/video?videoId=120654&udid=08eda8e6ceb44c7387c7cdb5db781a7c3ae1dd8a
Future<PageData> getReplies({int videoId,String nextUrl}) async {
  String url;
  if(videoId!=null) {
     url =
        "http://baobab.kaiyanapp.com/api/v2/replies/video?videoId=$videoId&udid=08eda8e6ceb44c7387c7cdb5db781a7c3ae1dd8a" +
            defaultParameter;
  }
  if(nextUrl!=null){
    url=nextUrl+defaultParameter;
  }
  Response response = await get(url, headers: _default);
  if (response.statusCode == 200) {
    if (response.body != null) {
      return PageData.fromJson(response.body);
    }
  } else {}
}

