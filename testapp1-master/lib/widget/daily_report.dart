import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testapp1/widget/colck.dart';

class DailyReportPage extends StatefulWidget {

  @override
  _DailyReportPageState createState() => _DailyReportPageState();
}

bool _isOpened = false;

class _DailyReportPageState extends State<DailyReportPage> {

  List<String> dayContents = ["20200909"];

  List<Widget> itemContents () {

    return dayContents
        .map((e) => Container(
      width: 350,
      height: 800,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.orangeAccent, width: 1),
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
        boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 1)],
      ),
      child: Column(
        children: [
          ClockWidget(widthCustom: 100),
          Row(
            children: [
              Column(
                children: [
                  Text(
                    " 작심문장 쓰기 !! ",
                    textScaleFactor: 1.2,
                  ),
                  Text("${e}",
                    textScaleFactor: 0.7,
                  ),
                ],
              ),
              Expanded(child: Container()),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.create),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.delete),
              ),
            ],
          ),
          SizedBox(
              height: 1,
              child: Container(
                color: Colors.orange,
              )),
          Expanded(
            child: ListView.builder(
                itemCount: 24,
                itemBuilder: (context, index){
                  return Column(
                    children: [
                      ListTile(
                        leading: Text("${index}"),
                        title: Text("${index} 시"),
                      ),
                      SizedBox(height: 1,child: Container(color: Colors.black45,))
                    ],
                  );
                }),
          ),
        ],
      ),
    ))
        .toList();
  }


  @override
  void initState() {
    _isOpened = true;
    super.initState();
  }

  @override
  void dispose() {
    _isOpened = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
            children: itemContents(),
          )),
    ) ;
  }

  _showDialog() async {
    TextEditingController _showDialogController = TextEditingController();
    await showDialog<String>(
      context: context,
      child: new AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content: new Row(
          children: <Widget>[
            new Expanded(
              child: new TextField(
                controller: _showDialogController,
                autofocus: true,
                decoration: new InputDecoration(
                    labelText: 'Full Name', hintText: 'eg. John Smith'),
              ),
            )
          ],
        ),
        actions: <Widget>[
          new FlatButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              }),
          new FlatButton(
              child: const Text('OPEN'),
              onPressed: () {
                Navigator.pop(context);
              })
        ],
      ),
    );
  }

}