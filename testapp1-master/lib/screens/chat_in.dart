
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:testapp1/size/size.dart';

class ChatRoomPage extends StatefulWidget {
  final int index;

  const ChatRoomPage(this.index, {Key key,}) : super(key: key);


  @override
  _ChatRoomPageState createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  // for Drawer
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<String> partnerList = ["강냉", "기배그", "지노", "태으여"];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        endDrawer: _drawer(),
        body: SafeArea(
            child: Column(
              children: [_titleHeader(), _mainContent()],
            )),
      ),
    );
  }

  Widget _titleHeader() {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              Navigator.pop(context, "");
            },
            icon: Icon(Icons.arrow_back)),
        Text("독서를 생활화 하는 사람들 (${widget.index})"),
        Text(
          " 6",
          style: TextStyle(fontSize: 10, color: Colors.grey),
        ),
        Expanded(
          child: Container(),
        ),
        IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              _scaffoldKey.currentState.openEndDrawer();
            }),
      ],
    );
  }

  Widget _mainContent() {
    return Container(height: size.height * 0.85, color: Colors.orangeAccent);
  }

  Stack _drawer() {
    return Stack(
      children: [
        SizedBox(
            width: size.width * 0.7,
            height: size.height,
            child: Container(
              color: Colors.white,
            )),
        SizedBox(
          width: size.width * 0.7,
          height: size.height,
          child: SingleChildScrollView(
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(left:8.0),
                child: Text(" 채팅방 서랍",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.only(left:8.0),
                child: Row(
                  children: [
                    Icon(Icons.photo_library),
                    Text(" 사진, 동영상"),
                    Expanded(
                      child: Container(),
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_forward_ios),
                      onPressed: () {},
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 50,
                child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1.0, color: Colors.white),
                          image: DecorationImage(
                              image: CachedNetworkImageProvider("https://picsum.photos/id/${index + 5}/100/100"),
                              fit: BoxFit.contain),
                          borderRadius: BorderRadius.all(Radius.circular(17)),
                          boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 1)],
                        ),
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(left:8.0),
                child: Row(
                  children: [
                    Icon(Icons.folder),
                    Text(" 파일"),
                    Expanded(
                      child: Container(),
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_forward_ios),
                      onPressed: () {},
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:8.0),
                child: Row(
                  children: [
                    Icon(Icons.all_inclusive),
                    Text(" 링크"),
                    Expanded(
                      child: Container(),
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_forward_ios),
                      onPressed: () {},
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:8.0),
                child: Row(
                  children: [
                    Text(
                      " 채팅방 캘린더",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_forward_ios),
                      onPressed: () {},
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:8.0),
                child: Row(
                  children: [
                    Text(
                      " 톡게시판",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_forward_ios),
                      onPressed: () {},
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:8.0),
                child: Text(
                  "참가자",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              Column(children: _partnerList()),
            ]),
          ),
        ),
      ],
    );
  }

  List<Widget> _partnerList() {
    int i = -1;
    return partnerList.map((content) {
      i = i + 1;
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                border: Border.all(width: 1.0, color: Colors.white),
                image: DecorationImage(
                    image: AssetImage(
                        (i == 0) ? "assets/user0.png" : "assets/user$i.gif"),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.all(Radius.circular(17)),
                boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 1)],
              ),
            ),
            i == 0 ? Text(" 대화상대 초대") : Text("  user $content")
          ],
        ),
      );
    }).toList();
  }
}