import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:testapp1/bottom_screens/loding.dart';
import 'package:testapp1/size/size.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

// Colors.primaries[index % Colors.primaries.length];

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                        itemCount: 15,
                        itemBuilder: (context, index) {
                          return (index == 0) ? _friendsList() : _postItem(index, context);
                        }),
                  )
                ],
              );
            }),
      ),
    );
  }

  Column _friendsList() {
    return Column(
      children: [
        Container(
          height: 64,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 15,
            itemBuilder: (context, index) {
              return RawMaterialButton(
                onPressed: () {
                  print("don't touch my face!");
                },
                //elevation: 14.0,
                highlightElevation: 50,
                fillColor: Colors.white,
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage("assets/person1.png"),
                ),
                shape: CircleBorder(),
              );
            },
          ),
        ),
        Container(
          height: 1,
          width: MediaQuery.of(context).size.width,
          color: Colors.grey,
        ),
      ],
    );
  }
  Column _postItem(int index, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _postHeader('username $index'),
        _postImage(index),
        _postActions(),
        _postLikes(),
        _postCaption(context, index),
        _allComments()
      ],
    );
  }

  FlatButton _allComments() {
    return FlatButton(
      onPressed: null,
      child: Text(
        'show all 18 comments',
        style: TextStyle(color: Colors.grey[600]),
      ),
    );
  }

  Padding _postCaption(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: common_gap, vertical: common_xs_gap),
      child: Text("Index: $index"),
    );
  }

  Padding _postLikes() {
    return Padding(
      padding: const EdgeInsets.only(left: common_gap),
      child: Text(
        '80 likes',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Row _postActions() {
    return Row(
      children: <Widget>[
        IconButton(
          onPressed: null,
          icon: ImageIcon(
            AssetImage("assets/bookmark.png"),
            color: Colors.black87,
          ),
        ),
        IconButton(
          onPressed: null,
          icon: ImageIcon(
            AssetImage("assets/comment.png"),
            color: Colors.black87,
          ),
        ),
        IconButton(
          onPressed: null,
          icon: ImageIcon(
            AssetImage("assets/direct_message.png"),
            color: Colors.black87,
          ),
        ),
        Spacer(),
        IconButton(
          onPressed: () {},
          icon: ImageIcon(
            AssetImage("assets/heart_selected.png"),
            color: Colors.red,
          ),
        ),
      ],
    );
  }

  String getProfileImgPath(String username){
    final encoder = AsciiEncoder();
    List<int> codes = encoder.convert(username);
    int sum = 0;
    codes.forEach((code)=> sum += code);

    final imgNum = sum%1000;

    return "https://picsum.photos/id/$imgNum/30/30";
  }

  Row _postHeader(String username) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(common_gap),
          child: CircleAvatar(
            backgroundImage:
            CachedNetworkImageProvider(getProfileImgPath(username)),
            radius: profile_radius,
          ),
        ),
        Expanded(child: Text(username)),
        IconButton(
          icon: Icon(
            Icons.more_horiz,
            color: Colors.black87,
          ),
          onPressed: null,
        )
      ],
    );
  }

  CachedNetworkImage _postImage(int index) {
    return CachedNetworkImage(
      imageUrl: 'https://picsum.photos/id/${index+66}/200/200',
      placeholder: (context, url) {
        return MyProgressIndicator();
      },
      imageBuilder: (context, ImageProvider imageProvider) => AspectRatio(
        aspectRatio: 1,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}
