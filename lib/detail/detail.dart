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

    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(image: DecorationImage(image: CachedNetworkImageProvider(widget.videoBeanForClient.cover.blurred),fit: BoxFit.cover)),
          child: Column(
            children: <Widget>[
              playerWidget,
              Expanded(
                child: ListView.builder(
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
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildVideoInfo(BuildContext context) {
    Widget title = Text(
      widget.videoBeanForClient.title,
      style: TextStyle(
          fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
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
            onPressed: null,
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
      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[title, description, action],
      ),
    );
  }

  Widget buildTags(BuildContext context) {
    List<Widget> tagWidgets = widget.videoBeanForClient.tags.map((tag) {
      return Container(
        height: 56.0,
        width: (MediaQuery.of(context).size.width - 40) /
            widget.videoBeanForClient.tags.length,
        alignment: Alignment.center,
        child: Text(
          tag.name,
          style: TextStyle(color: Colors.white, fontSize: 12.0),
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
            image: DecorationImage(image: NetworkImage(tag.bgPicture))),
      );
    }).toList();
    return Padding(
      padding: const EdgeInsets.only(left: 12.0,top: 8.0, right: 12.0,bottom: 8.0),
      child: Row(
        children: tagWidgets,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
          padding: const EdgeInsets.only(left:12.0),
          child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
          Text(
            widget.videoBeanForClient.author.name,
            style: TextStyle(
                color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.bold),
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

class ImageDetailPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
  }
}

class _ImageDetailState extends State<ImageDetailPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
  }
}
