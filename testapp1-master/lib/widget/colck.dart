import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:testapp1/size/size.dart';
import 'package:testapp1/util/utils.dart';
import 'package:testapp1/widget/daily_report.dart';


// 1 - 60       : 0시
// 61 - 120     : 1시
// 121 - 180    : 2시
// 181 - 240    : 3시

class ClockWidget extends StatefulWidget {

  final double widthCustom;
  final int year;
  final int month;
  final int day;

  ClockWidget({this.widthCustom, this.year, this.month, this.day});

  @override
  _ClockWidgetState createState() => _ClockWidgetState();
}

class _ClockWidgetState extends State<ClockWidget> {

  double _widthCustom;

  int index = 0; // current index
  double prev_total = 0;
  double temp_value; // store current angle value

  List<double> reports = [];

  Map<String, double> dataMap = {
    "Empty": 1440,
  };

  @override
  void initState() {
    if(widget.widthCustom == null)
      _widthCustom = size.width;
    else
      _widthCustom = widget.widthCustom;

    super.initState();
  }

  void _addReport() {
    reports.add(temp_value - prev_total);
    prev_total = temp_value;
    index = index + 1;
  }

  int _getIndexFromValue(double angleValue) {

    int i = 0;
    bool flag = false;
    double sum = 0;

    for(int j = 0; j < reports.length; j++){
      sum = sum + reports[j];
      flag = true;
      if ( angleValue > sum)
        i = i + 1;
      else
        break;
    }

    return flag? ((i == reports.length)? 9999 : i ): 9999; // 1.    length same : empty click 2. 9999 empty space now
  }

  bool _availabeAngleValue(double angleValue){

  }

  void _UpdateDataMapReports(double StartValue, double EndValue){

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: _widthCustom,
        height: _widthCustom,
        child: Stack(
          children: [
            Container(color: Colors.white,),
            Text("\n ${widget.year} - ${widget.month} - ${widget.day}"),
            Center(
              child: Container(
                width: _widthCustom / 1.1,
                height: _widthCustom / 1.1,
                decoration: new BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            PieChart(
              dataMap: dataMap,
              animationDuration: Duration(milliseconds: 100),
              chartLegendSpacing: 32,
              chartRadius: _widthCustom / 1.3,
              colorList: [
                Colors.blue,
                Colors.green,
                Colors.purple,
                Colors.black,
                Colors.brown
              ],
              initialAngleInDegree: 270,

              // 1440 으로 나누기
              chartType: ChartType.disc,
              ringStrokeWidth: 32,
              legendOptions: LegendOptions(
                showLegends: false,
              ),
              chartValuesOptions: ChartValuesOptions(
                showChartValueBackground: false,
                // chartValueBackgroundColor: Colors.black,
                showChartValues: true,
                showChartValuesInPercentage: false,
                showChartValuesOutside: false,
                chartValueStyle:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            GestureDetector(
              onScaleStart: (a){
              },
              onScaleEnd: (a){
              },
              onScaleUpdate: (a) {
                _handlePan(a.focalPoint, context);
              },
              child: Center(
                child: Opacity(
                  opacity: 0,
                  child: Container(
                      width: _widthCustom / 1.1,
                      height: _widthCustom / 1.1,
                      decoration: new BoxDecoration(
                        color: Colors.orange,
                        shape: BoxShape.circle,
                      )),
                ),
              ),
            ),
            GestureDetector(
              onTapDown: (a) {
                int ith_report = _getIndexFromValue(_getValueFromOffset(a.globalPosition));
                if (ith_report != 9999)
                  showAlertDialog_ReportPress(context, ith_report);
              },
              onLongPress: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => DailyReportPage()));
              },
              child: Center(
                child: Opacity(
                  opacity: 0,
                  child: Container(
                      width: _widthCustom / 1.3,
                      height: _widthCustom / 1.3,
                      decoration: new BoxDecoration(
                        color: Colors.orange,
                        shape: BoxShape.circle,
                      )),
                ),
              ),
            ),
            FlatButton(
              onPressed: () {showAlertDialog_addPress(context);
              },
              child: Text('flag'),
            ),
          ],
        ),
      ),
    );
  }


  double _getValueFromOffset(Offset detailsValue){
    int divisions = 1440;
    RenderBox renderBox = context.findRenderObject();
    var position = renderBox.globalToLocal(detailsValue);

    var angle = coordinatesToRadians(Offset(220.0, 411.0), position);
    var percentage = radiansToPercentage(angle);
    int newValue = percentageToValue(percentage, divisions);

    return newValue.toDouble();
  }

  void _handlePan(Offset details, BuildContext context) {
    double newValue = _getValueFromOffset(details);
    temp_value = newValue;
    print(details);
    setState(() {
      dataMap.remove("Empty");
      dataMap["$index"] = newValue - prev_total;
      dataMap["Empty"] = 1440 - newValue;
    });
  }

  void showAlertDialog_ReportPress(BuildContext context, int i_index) async {
    String result = await showDialog(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          final titleTextController = TextEditingController();
          final addLocationController = TextEditingController();
          final addTextController = TextEditingController();

          double start = 0;

          for(int i = 0; i < i_index; i++) {
            start = start + reports[i];
          }

          return AlertDialog(
            title: Text('$i_index 리포트 내용 추가'),
            content: Column(
              children: [
                Row(children: [
                  TextField(autofillHints: <String>["$i_index"], controller: titleTextController, style: TextStyle(fontSize: 15),
                    maxLines: 1,), Expanded(child:Container()), IconButton(onPressed: (){},icon: Icon(Icons.arrow_drop_down_circle, color: Colors.red,))
                ] ),
                Row(children: [
                  Text("시작"), Expanded(child:Container()), Text("$start 분")
                ] ),
                Row(children: [
                  Text("종료"), Expanded(child:Container()), Text("${start + reports[i_index]} 분")
                ] ),
                Row(
                  children: [
                    Icon(Icons.add_location),
                    TextField(
                      controller: addLocationController,
                      style: TextStyle(fontSize: 12),
                      maxLines: 1,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.add_alert),
                    Text("10분전"),
                    Expanded(child: Container()),Radio(value: bool, groupValue: bool, onChanged: (a){print(a);})
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.create),
                    TextField(
                      controller: addTextController,
                      style: TextStyle(fontSize: 12),
                      maxLines: 1,)
                  ],
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                color: Colors.deepOrangeAccent,
                child:
                Text('편집', style: TextStyle(fontWeight: FontWeight.bold)),
                onPressed: () {
                  Navigator.pop(context, "생성");
                },
              ),
              FlatButton(
                color: Colors.grey,
                child: Text(
                  '취소',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.pop(context, "취소");
                },
              ),
            ],
          );
        });
  }

  void showAlertDialog_addPress(BuildContext context) async {
    String result = await showDialog(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          final addTextController = TextEditingController();

          return AlertDialog(
            title: Text('리포트 추가'),
            content: TextField(
              controller: addTextController,
              style: TextStyle(fontSize: 12),
              maxLines: 1,
            ),
            actions: <Widget>[
              FlatButton(
                color: Colors.deepOrangeAccent,
                child:
                Text('생성', style: TextStyle(fontWeight: FontWeight.bold)),
                onPressed: () {
                  setState(() {
                    _addReport();
                  });
                  Navigator.pop(context, "생성");
                },
              ),
              FlatButton(
                color: Colors.grey,
                child: Text(
                  '취소',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  setState(() {
                    dataMap.remove("$index");
                  });
                  Navigator.pop(context, "취소");
                },
              ),
            ],
          );
        });
  }
}