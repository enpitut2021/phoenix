///package~
import 'package:flutter/material.dart';
import 'package:phoenix/common_widget/common_tile.dart';

///----------------make text list widget---------------------
class CommonList {
  List<Widget> tiles = [];

  void addTiles(String text, double width, TextStyle textstyle, CommonTile tile,
      {void Function()? onPress}) {
    // if (text.isEmpty) {
    //   tiles.add(tile.build());
    // }
    tiles.add(tile.build(onPress: onPress));
  }
//
// Widget _tile(String text, double width, TextStyle textstyle) {
// return Container(
//   child: Text(
//     text,
//     style: textstyle,
//   ),
//   width: width,
//   margin: const EdgeInsets.all(2),
//   decoration: BoxDecoration(
//     border: Border.all(color: Colors.white10, width: 1),
//   ),
// );
// }

  Widget menueDetailMaterial({required Widget titlewidget}) {
    Widget menudetail = Column(
      children: [
        titlewidget,
        Column(
          children:
              // makeTextList(materials, screenwidth, const TextStyle(fontSize: 15)),
              tiles,
        ),
      ],
    );
    return menudetail;
  }
}
///----------------make text list widget----------------------