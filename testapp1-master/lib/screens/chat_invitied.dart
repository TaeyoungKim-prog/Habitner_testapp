import 'package:flutter/material.dart';
import 'package:testapp1/size/size.dart';


class InviteMemberScreen extends StatefulWidget {
  @override
  _InviteMemberScreenState createState() => _InviteMemberScreenState();
}

class _InviteMemberScreenState extends State<InviteMemberScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Column(
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
                      IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
                      Text("    파트너 초대 ",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ],
                  )),
              TextField(
                decoration: InputDecoration(
                  hintStyle: TextStyle(
                      color: Colors.grey
                  ),
                  hintText: " 닉네임 검색",
                ),
              )
            ],
          ),
        ));
  }
}