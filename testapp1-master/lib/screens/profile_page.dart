import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:testapp1/screens/profile_img_path.dart';
import 'package:testapp1/screens/profile_sidemenu.dart';
import 'package:testapp1/size/size.dart';
import 'package:testapp1/widget/calender.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with SingleTickerProviderStateMixin{
  AnimationController _animationController;
  bool _menuOpened = false;
  Size _size;
  double menuWidth;
  int duration = 200;
  AlignmentGeometry tabAlign = Alignment.centerLeft;
  bool _tabIconGridSelected = true;
  double _gridMargin = 0;
  double _myImgGridMargin;

  ScrollController _scrollController = ScrollController();

  bool leftFlag;

  @override
  void initState(){
    _animationController = AnimationController(vsync: this, duration: Duration(microseconds: duration));
    leftFlag = true;

    super.initState();
  }

  @override
  void dispose(){
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _myImgGridMargin = MediaQuery.of(context).size.width;
    _size = MediaQuery
        .of(context)
        .size;
    menuWidth = MediaQuery
        .of(context)
        .size.width / 1.5;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            _profile(),
            _sideMenu(),
          ],
        ),
      ),
    );
  }

  Widget _sideMenu() {
    return AnimatedContainer(
      curve: Curves.easeInOut,
      color: Colors.grey[200],
      duration: Duration(milliseconds: duration),
      transform: Matrix4.translationValues(
          _menuOpened ? _size.width - menuWidth : _size.width, 0, 0),
      child: SafeArea(
        child: SizedBox(
          width: menuWidth,
          child: ProfileSideMenu(),
        ),
      ),
    );
  }

  Widget _profile() {
    return AnimatedContainer(
      curve: Curves.easeInOut,
      color: Colors.transparent,
      duration: Duration(milliseconds: duration),
      transform: Matrix4.translationValues(_menuOpened ? -menuWidth : 0, 0, 0),
      child: SafeArea(
        child: Column(
          children: <Widget>[
            _usernameIconButton(),
            Expanded(
              child: leftFlag?  Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _getProfileHeader,
                  _username(),
                  _userBio(),
                  _editProfileBtn(),
                  _getTabIconButtons,
                  _getAnimatedSelectedBar,
                 // _getImageGrid(context)
                 Expanded(child:SingleChildScrollView(child: Calendar()) )

              ],) : CustomScrollView(
                slivers: <Widget>[
                  SliverList(
                    delegate: SliverChildListDelegate([
                      _getProfileHeader,
                      _username(),
                      _userBio(),
                      _editProfileBtn(),
                      _getTabIconButtons,
                      _getAnimatedSelectedBar,
                    ]),
                  ),
                 _getImageGrid(context)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  SliverToBoxAdapter _getImageGrid(BuildContext context) => SliverToBoxAdapter(
    child: Stack(
      children: <Widget> [

        AnimatedContainer(
          transform: Matrix4.translationValues(leftFlag ? size.width : 0 , 0, 0),
          duration: Duration(microseconds: 11111),
          curve: Curves.easeInOut,
          child: _imageGrid,
        ),

        AnimatedContainer(
          transform: Matrix4.translationValues(leftFlag ? 0 : -size.width, 0, 0),
          duration: Duration(microseconds: 11111),
          curve: Curves.easeInOut,
          child: Calendar(),
        ),
      ],
    ),
  );
  GridView get _imageGrid => GridView.count(
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    crossAxisCount: 3,
    childAspectRatio: 1,
    children: List.generate(30, (index) => _gridImgItem(index)
    ),
  );

  CachedNetworkImage _gridImgItem(int index) => CachedNetworkImage(
      fit: BoxFit.cover,
      imageUrl : "https://picsum.photos/id/${index+20}/100/100"
  );

  Padding _editProfileBtn() {
    return Padding(
      padding: const EdgeInsets.all(common_gap),
      child: SizedBox(
        height: 24,
        child: OutlineButton(
          onPressed: () {},
          borderSide: BorderSide(color: Colors.black45),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6)),
          child: Text(
            'Edit Profile',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Padding _userBio() {
    return Padding(
      padding: const EdgeInsets.only(left: common_gap),
      child: Text(
        'Bio from User. so Say something',
        style: TextStyle(fontWeight: FontWeight.w400),
      ),
    );
  }

  Padding _username() {
    return Padding(
      padding: const EdgeInsets.only(left: common_gap),
      child: Text(
        'User Real Name',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Row get _getProfileHeader =>
      Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(common_gap),
            child: CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('assets/user1234.png'),
            ),
          ),
          Expanded(
            child: Table(
              children: [
                TableRow(children: [
                  _getStatusValueWidget('13'),
                  _getStatusValueWidget('23'),
                  _getStatusValueWidget('124'),
                ]),
                TableRow(children: [
                  _getStatusLabelWidget('post'),
                  _getStatusLabelWidget('Followers'),
                  _getStatusLabelWidget('Following'),
                ]),
              ],
            ),
          ),
        ],
      );

  Widget _getStatusValueWidget(String value) =>
      Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: common_s_gap),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      );

  Widget _getStatusLabelWidget(String value) =>
      Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: common_s_gap),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w300),
            ),
          ),
        ),
      );

  Row _usernameIconButton() {
    return Row(
      children: <Widget>[
        Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: common_gap),
              child: Text(
                'theCodingpapa',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            )),
        IconButton(
          icon: AnimatedIcon(
            icon: AnimatedIcons.menu_close,
            progress: _animationController,
            semanticLabel: 'Show menu',
          ),
          onPressed: () {
            _menuOpened ? _animationController.reverse() : _animationController.forward();
            setState(() {
              _menuOpened = !_menuOpened;
            });
          },
        )
      ],
    );
  }

  Widget get _getTabIconButtons =>
      Row(
        children: <Widget>[
          Expanded(
            child: IconButton(
              icon: ImageIcon(AssetImage("assets/grid.png"),
                color: _tabIconGridSelected ? Colors.black : Colors.black26,
              ),
              onPressed: () {
                setState(() {
                  leftFlag = true;
                });
                _setTab(true);
              },
            ),
          ),
          Expanded(
            child: IconButton(
              icon: ImageIcon(AssetImage("assets/saved.png"),
                color: _tabIconGridSelected ? Colors.black26 : Colors.black,),
              onPressed: () {
                setState(() {
                  leftFlag = false;
                });
                _setTab(false);
              },
            ),
          )
        ],
      );

  Widget get _getAnimatedSelectedBar => AnimatedContainer(
    alignment: tabAlign,
    duration: Duration(microseconds: duration),
    curve: Curves.easeInOut,
    color: Colors.transparent,
    height: 1,
    width: MediaQuery.of(context).size.width,
    child: Container(
      height: 1,
      width: MediaQuery.of(context).size.width /2,
      color: Colors.black87,
    ),
  );
  _setTab(bool tabLeft){
    setState(() {
      if (tabLeft){
        this.tabAlign = Alignment.centerLeft;
        this._tabIconGridSelected = true;
        this._gridMargin = 0;
        this._myImgGridMargin = MediaQuery.of(context).size.width;
      }else{
        this.tabAlign = Alignment.centerRight;
        this._tabIconGridSelected = false;
        this._gridMargin = -MediaQuery.of(context).size.width;
        this._myImgGridMargin = 0;
      }
    });
  }
}

