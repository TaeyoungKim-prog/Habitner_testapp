import 'package:date_util/date_util.dart';
import 'package:flutter/material.dart';
import 'package:testapp1/size/size.dart';
import 'package:testapp1/widget/colck.dart';


class Calendar extends StatefulWidget {



  final int year;
  final int month;

  Calendar({this.year = 2020 , this.month = 9});

  @override
  _CalendarState createState() => _CalendarState();
}


class _CalendarState extends State<Calendar> {

  bool isUp = true;

  double oneBox_height = (size.height/2 - 95) / 6;
  double oneBox_height_down = (size.height*0.9 - 95) / 6;
  int now_year;
  int now_month;

  bool isLoading = true;
  bool _dragFlag = false;

  @override
  void initState() {
    now_year = widget.year;
    now_month = widget.month;

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _calendar(),
//        GestureDetector(
//          onVerticalDragStart: (a){
//            _dragFlag = true;
//          },
//          onVerticalDragUpdate: (a){
//            if (_dragFlag) {
//              _dragFlag = false;
//              if(a.delta.dy > 0) isUp = false;
//              else if(a.delta.dy < 0) isUp = true;
//            }
//            setState((){});
//          },
//        )
      ],
    );
  }

  Widget _calendar() {
    return Column(
      children: [date_bar(), week_title(), week_line(), SizedBox(height: 1,child:Container(color:Colors.grey))],
    );
  }
  Widget date_bar(){
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right:20.0, bottom: 5.0),
      child: Container(
        height: 30,
        child: Row(
          children: [
            IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){
              setState((){
                now_year = (now_month == 1) ? now_year - 1 : now_year;
                now_month = (now_month == 1) ? 12 : now_month -1;
              });
            }),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Text('$now_year $now_month'),
            ),
            Spacer(),
            IconButton(icon: Icon(Icons.arrow_forward_ios), onPressed: (){
              setState((){
                now_year = (now_month == 12) ? now_year + 1 : now_year;
                now_month = (now_month == 12) ? 1 : now_month + 1;
              });
            }),
          ],),
      ),
    );
  }

  Widget week_title() {
    return Row(
      children: [
        Spacer(),
        title_box('월', Colors.black),
        title_box('화', Colors.black),
        title_box('수', Colors.black),
        title_box('목', Colors.black),
        title_box('금', Colors.black),
        title_box('토', Colors.blue),
        title_box('일', Colors.red),
        Spacer(),
      ],
    );
  }

  Widget title_box(String weekday, Color TextColor) {
    return Container(
        height: 40,
        width: 50,
        child: Row(
          children: [
            Spacer(),
            Text(
              weekday,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 20, color: TextColor),
            ),
            Spacer(),
          ],
        ));
  }

  Widget week_line() {
    // 월 : 1, 화 : 2, 수 : 3, 목 : 4, 금 : 5, 토 : 6, 일 : 7

    int year = now_year;
    int month = now_month;

    int diff_day = DateTime.now().day - 1;
    //DateTime first_day = DateTime.now().subtract(Duration(days: diff_day));
    DateTime first_day = DateTime(year, month, 1);

    var dateUtility = new DateUtil();

    List<List<int>> days = [];

    int day_temp = 1;

    for (int i = 0; i < 6; i++) {
      days.add([]);
      for (int j = 1; j < 8; j++) {
        if (i == 0) {
          if (j >= first_day.weekday)
            days[i].add(day_temp++);
          else
            days[i].add(0);
        } else {
          if (day_temp > dateUtility.daysInMonth(month, year)) {
            days[i].add(0);
          } else
            days[i].add(day_temp++);
        }
      }
    }

    return Row(
      children: [
        Spacer(),
        Column(
            children: List.generate(
                6,
                    (index_1) => Row(
                    children: List.generate(
                        7,
                            (index_2) => day_box([now_year, now_month, days[index_1][index_2]],
                            "${days[index_1][index_2]}", index_2 + 1, index_1))
                        .toList())).toList()),
        Spacer(),
      ],
    );
  }

  Widget day_box(List<int> date_time, String day, int week_day, int week_num) {
    Color TextColor = Colors.black;

    if (week_day == 6) TextColor = Colors.blue;
    if (week_day == 7) TextColor = Colors.red;


    return AnimatedContainer(
        width: 50,
        height: isUp ? oneBox_height : oneBox_height_down,
        curve: Curves.fastOutSlowIn,
        duration: Duration(milliseconds: 400),
        transform: Matrix4.translationValues(0, 0, 0),
        child: GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => ClockWidget(year: date_time[0],month: date_time[1],day: date_time[2])));
          },
          child: Container(
              width: 50,
              child: (day == '0') ? Text('') : Column(
                children: [
                  Text(
                    day,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 12, color: TextColor),
                  ),
                ],
              )),
        ));
  }


  int check_sucess(List<Map<String, dynamic>> check_list){
    int num = 0;

    for ( int i = 0; i < check_list.length ; i++ ){
      if(check_list[i]['check']) num++;
    }

    return num;
  }

}