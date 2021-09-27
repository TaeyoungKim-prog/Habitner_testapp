import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:testapp1/bottom_screens/loding.dart';
import 'package:testapp1/screens/search_d.dart';

//List<StaggeredTile> _staggeredTiles = const <StaggeredTile>[
//  const StaggeredTile.count(2, 2),
//  const StaggeredTile.count(2, 1),
//  const StaggeredTile.count(1, 2),
//  const StaggeredTile.count(1, 1),
//  const StaggeredTile.count(2, 2),
//  const StaggeredTile.count(1, 2),
//  const StaggeredTile.count(1, 1),
//  const StaggeredTile.count(3, 1),
//  const StaggeredTile.count(1, 1),
//  const StaggeredTile.count(4, 1),
//];

//List<Widget> _tiles = <Widget>[
//
//   _Example01Tile(Colors.green, Icons.widgets),
//   _Example01Tile(Colors.lightBlue, Icons.wifi),
//   _Example01Tile(Colors.amber, Icons.panorama_wide_angle),
//   _Example01Tile(Colors.brown, Icons.map),
//   _Example01Tile(Colors.deepOrange, Icons.send),
//   _Example01Tile(Colors.indigo, Icons.airline_seat_flat),
//   _Example01Tile(Colors.red, Icons.bluetooth),
//   _Example01Tile(Colors.pink, Icons.battery_alert),
//   _Example01Tile(Colors.purple, Icons.desktop_windows),
//   _Example01Tile(Colors.blue, Icons.radio),
//];
int index_a = 40;
List<StaggeredTile> _staggeredTiles1 = List.generate(index_a, (index) {
  if (index % 4 == 0) {
    return StaggeredTile.count(2, 2);
  }
  return StaggeredTile.count(1, 1);
});
List<Widget> _tiles = List.generate(index_a, (index) {
  return _Example01Tile(Colors.green, Icons.widgets);
});

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Column(
            children: <Widget>[
              Container(
                height: 60,
                color: Colors.red,
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TestPage1(),
                          ),
                        );
                      },
                    ),
                    Text(
                      "검색",
                      style: TextStyle(fontSize: 15, color: Colors.grey),
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
          Expanded(
            child: new StaggeredGridView.count(
              crossAxisCount: 4,
              staggeredTiles: _staggeredTiles1,
              children: _tiles,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
            ),
          ),
        ],
      ),
    ));
  }
}

class _Example01Tile extends StatefulWidget {
  const _Example01Tile(this.backgroundColor, this.iconData);

  final Color backgroundColor;
  final IconData iconData;

  @override
  __Example01TileState createState() => __Example01TileState();
}

class __Example01TileState extends State<_Example01Tile> {
  @override
  Widget build(BuildContext context) {
    var rng = new Random();
    return _gridImgItem(rng.nextInt(100));
  }

  CachedNetworkImage _gridImgItem(int index) => CachedNetworkImage(
      placeholder: (context, url) {
        return MyProgressIndicator();
      },
      fit: BoxFit.cover,
      imageUrl: "https://picsum.photos/id/${index + 50}/100/100");
}
