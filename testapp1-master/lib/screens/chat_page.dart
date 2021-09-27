import 'package:flutter/material.dart';
import 'package:testapp1/screens/chat_in.dart';
import 'package:testapp1/screens/chat_invitied.dart';
import 'package:testapp1/size/size.dart';

class ChatList extends StatefulWidget {
  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {

  bool isClickAddChatRoom = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Stack(
              children: [
                _mainChatList(context),
                isClickAddChatRoom ? Container(width: size.width, height: size.height, color: Colors.black54,) : Container(),
              ],
            ),
            AnimatedContainer(
              width: size.width,
              height: size.height,
              curve: Curves.fastOutSlowIn,
              transform: Matrix4.translationValues(0, isClickAddChatRoom ? 0 : - size.height, 0),
              duration: Duration(milliseconds: 500),
              child: _AddChatRoom(),
            )
          ],
        ),
      ),
    );
  }

  Widget _AddChatRoom(){
    return Column(children: [
      Container(
          height: 200,
          width: size.width,
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(0, 1))
              ]),
          child: Column(
            children: [
              SizedBox(
                height: 60,
                child: Row(
                  children: [
                    IconButton(onPressed: (){
                      setState(() {
                        isClickAddChatRoom = false;
                      });
                    }, icon: Icon(Icons.arrow_back),),
                    Text(" 새로운 채팅",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              SizedBox(
                height: 140,
                child: Row(
                  children: [
                    Spacer(),
                    InkWell(
                        onTap: (){
                          setState((){
                            isClickAddChatRoom = false;
                          });
                          Navigator.push(context, MaterialPageRoute(builder: (context) => InviteMemberScreen()));
                        },
                        child: Image.asset("assets/addChat1.png")),
                    Spacer(),
                    InkWell(
                        onTap: (){},
                        child: Image.asset("assets/addChat2.png")),
                    Spacer(),
                  ],
                ),
              )
            ],
          )),
      Text("강냉님 이런 모임은 어떠신가요?", textAlign: TextAlign.center, style: TextStyle(fontSize: 14, color: Colors.white),)
    ],);
  }

  Column _mainChatList(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 60,
            width: size.width,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(0, 1))
                ]),
            child: Row(
              children: [
                Text("    채팅",
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                Expanded(
                  child: Container(),
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.search)),
                InkWell(
                  child: Image.asset(
                    "assets/add_chat.png",
                    width: 50,
                  ),
                  onTap: () {
                    setState((){
                      isClickAddChatRoom = true;
                    });
                  },
                ),
                InkWell(
                  child: Image.asset(
                    "assets/settings.png",
                    width: 50,
                  ),
                  onTap: () {},
                )
              ],
            )),
        Expanded(
          child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Container(
                      height: 70,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                border:
                                Border.all(width: 1.0, color: Colors.white),
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/user${index % 4 + 1}.gif"),
                                    fit: BoxFit.cover),
                                borderRadius:
                                BorderRadius.all(Radius.circular(17)),
                                boxShadow: [
                                  BoxShadow(color: Colors.grey, blurRadius: 1)
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text("독서를 생활화 하는 사람들",
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.black)),
                                    Text(
                                      "  16",
                                      style: TextStyle(
                                          fontSize: 10, color: Colors.grey),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(vertical: 3.0),
                                  child: Text("작심문장을 업로드헀습니다.",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.grey)),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                          Column(
                            children: [
                              Spacer(),
                              Text("오후 11:05    ",
                                  style: TextStyle(
                                      fontSize: 8, color: Colors.grey)),

                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: Container(
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    border: Border.all(
                                        width: 1.0, color: Colors.white),
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(17)),
                                    boxShadow: [],
                                  ),
                                  child: Text("+ 1 ", textAlign: TextAlign.center, style: TextStyle(color: Colors.yellow, fontSize: 12)),
                                ),
                              ),
                              Spacer(),
                            ],
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap:(){
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return ChatRoomPage(index);
                        }));
                      },
                      child: Container( height: 70, color: Colors.transparent,),
                    )
                  ],
                );
              }),
        ),
        FlatButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ChatRoomPage(9999)));
            },
            child: Text("채팅방으로")),
      ],
    );
  }
}