import 'package:flutter/material.dart';
import 'package:testapp1/size/size.dart';

class TestPage1 extends StatefulWidget {
  @override
  _TestPage1State createState() => _TestPage1State();
}

class _TestPage1State extends State<TestPage1> {
  final msteri = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              height: 60,
              color: Colors.red,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(
                          context,"das"
                      );
                    },
                  ),
                  SizedBox(
                    width: 300,

                    child: TextField(
                      controller: msteri,
                      onSubmitted: (String value) async {
                        await showDialog<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Thanks!'),
                              content: Text('You typed "$value".'),
                              actions: <Widget>[
                                FlatButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
