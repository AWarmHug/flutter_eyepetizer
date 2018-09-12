import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/data/bean/page_data.dart';
import 'package:flutter_eyepetizer/utils/app_icons.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_eyepetizer/data/data_manager.dart';

class VideoDetailPage extends StatefulWidget {
  VideoBeanForClient videoBeanForClient;

  VideoDetailPage(this.videoBeanForClient);

  @override
  State<StatefulWidget> createState() {
    return _VideoDetailState();
  }
}

class _VideoDetailState extends State<VideoDetailPage> {
  List<ContentItem> _contentItems = [];

  int index = 0;

  @override
  void initState() {
    getVideoRelated(widget.videoBeanForClient.id).then((contentItems) {
      setState(() {
        this._contentItems = contentItems;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final playerWidget = new Chewie(
      new VideoPlayerController.network(widget.videoBeanForClient.playUrl),
      aspectRatio: 5 / 3,
      autoPlay: true,
      looping: true,
    );
    return WillPopScope(
      onWillPop: (){
        if(index==1){
          setState(() {
            index=0;
          });
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: MaterialApp(
        home: Scaffold(
          body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: CachedNetworkImageProvider(
                        widget.videoBeanForClient.cover.blurred),
                    fit: BoxFit.cover)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                playerWidget,
                Expanded(
                  child: IndexedStack(index: index, children: <Widget>[
                    ListView.builder(
                      itemBuilder: (context, position) {
                        switch (position) {
                          case 0:
                            return buildVideoInfo(context);
                          case 1:
                            return buildTags(context);
                          case 2:
                            return buildAuthor(context);
                          default:
                            return buildRelatedInfo(context, position - 3);
                        }
                      },
                      itemCount: _contentItems.length + 3,
                    ),
                    CommentList(widget.videoBeanForClient.id)
                  ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildVideoInfo(BuildContext context) {
    Widget title = Container(
      color: Colors.black,
      child: Text(
        widget.videoBeanForClient.title,
        style: TextStyle(
            fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );

    Widget description = Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(
        widget.videoBeanForClient.description,
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.white70),
      ),
    );
    Widget action = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        FlatButton.icon(
            onPressed: null,
            icon: Icon(
              AppIcons.like,
              color: Colors.white,
              size: 20.0,
            ),
            label: Text(
              "${widget.videoBeanForClient.consumption.collectionCount}",
              style: TextStyle(color: Colors.white, fontSize: 12.0),
              textAlign: TextAlign.center,
            )),
        FlatButton.icon(
            onPressed: null,
            icon: Icon(
              AppIcons.share,
              color: Colors.white,
              size: 20.0,
            ),
            label: Text(
              "${widget.videoBeanForClient.consumption.shareCount}",
              style: TextStyle(color: Colors.white, fontSize: 12.0),
              textAlign: TextAlign.center,
            )),
        FlatButton.icon(
            onPressed: () {
              setState(() {
                index = 1;
              });
            },
            icon: Icon(
              AppIcons.reply,
              color: Colors.white,
              size: 20.0,
            ),
            label: Text(
              "${widget.videoBeanForClient.consumption.replyCount}",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.0,
              ),
              textAlign: TextAlign.center,
            )),
        FlatButton.icon(
            onPressed: null,
            icon: Icon(
              AppIcons.download,
              color: Colors.white,
              size: 20.0,
            ),
            label: Text(
              "缓存",
              style: TextStyle(color: Colors.white, fontSize: 12.0),
              textAlign: TextAlign.center,
            )),
      ],
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[title, description, action],
      ),
    );
  }

  Widget buildTags(BuildContext context) {
    List<Widget> tagWidgets = widget.videoBeanForClient.tags.take(3).map((tag) {
      return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        child: Container(
          height: 64.0,
          width: (MediaQuery.of(context).size.width - 48) / 3,
          alignment: Alignment.center,
          child: Text(
            "#${tag.name}#",
            style: TextStyle(
                color: Colors.white,
                fontSize: 12.0,
                fontWeight: FontWeight.bold),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
            image: DecorationImage(
                image: NetworkImage(tag.bgPicture), fit: BoxFit.cover),
          ),
        ),
      );
    }).toList();
    return Padding(
      padding:
          const EdgeInsets.only(left: 12.0, top: 8.0, right: 12.0, bottom: 8.0),
      child: Row(
        children: tagWidgets,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
    );
  }

  Widget buildAuthor(BuildContext context) {
    Widget icon = ClipOval(
        child: CachedNetworkImage(
      imageUrl: widget.videoBeanForClient.author.icon,
      placeholder: buildPlaceHolder(42.0, 42.0),
      errorWidget: new Icon(Icons.error),
      width: 42.0,
      height: 42.0,
    ));
    Widget info = Expanded(
        child: Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.videoBeanForClient.author.name,
            style: TextStyle(
                color: Colors.white,
                fontSize: 14.0,
                fontWeight: FontWeight.bold),
          ),
          Text(
            widget.videoBeanForClient.author.description,
            style: TextStyle(
                color: Colors.white70,
                fontSize: 12.0,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    ));

    return Container(
        padding:
            EdgeInsets.only(left: 12.0, top: 8.0, right: 12.0, bottom: 8.0),
        child: Row(
          children: <Widget>[icon, info],
        ));
  }

  Widget buildRelatedInfo(BuildContext context, int position) {
    return _contentItems[position].getWidget(context);
  }
}

class CommentList extends StatefulWidget {
  int videoId;

  CommentList(this.videoId);

  @override
  _CommentListState createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  PageData pageData;

  @override
  void initState() {
    load(videoId: widget.videoId);
    super.initState();
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
            load(nextUrl: pageData.nextPageUrl);
          }
          return pageData.itemList[position].getWidget(context);
        },
      );
    }
  }

  void load({int videoId, String nextUrl}) {
    getReplies(videoId: videoId, nextUrl: nextUrl).then((pageData) {
      setState(() {
        if (this.pageData == null) {
          this.pageData = pageData;
        } else {
          this.pageData += pageData;
        }
      });
    });
  }
}
