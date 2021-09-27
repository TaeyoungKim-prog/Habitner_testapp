import 'package:flutter/material.dart';
import 'package:testapp1/screens/chat_page.dart';
import 'package:testapp1/screens/home_page.dart';
import 'package:testapp1/screens/profile_page.dart';
import 'package:testapp1/screens/search_page.dart';
import 'package:testapp1/screens/search_d.dart';
import 'package:testapp1/size/size.dart';

class Menu_List extends StatefulWidget {
  Menu_List({Key key}) : super(key: key);

  @override
  _Menu_ListState createState() => _Menu_ListState();
}

class _Menu_ListState extends State<Menu_List> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    SearchPage(),
    ChatList(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(size == null){
      size = MediaQuery.of(context).size;
    }
    return Scaffold(
      body: Container(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text(''),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text(''),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            title: Text(''),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_pin),
            title: Text(''),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
