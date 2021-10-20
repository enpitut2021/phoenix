///package~
import 'package:flutter/material.dart';

///----------------make text list widget---------------------
List<Widget> makeTextList(
    List<String> texts, double width, TextStyle textstyle) {
  List<Widget> lists = [];
  if (texts.length == 0) {
    lists.add(_tile('', width, textstyle));
  }

  for (var text in texts) {
    lists.add(_tile(text, width, textstyle));
  }
  return lists;
}

Widget _tile(String text, double width, TextStyle textstyle) {
  return Container(
    child: Text(
      text,
      style: textstyle,
    ),
    width: width,
    margin: const EdgeInsets.all(2),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.white10, width: 1),
    ),
  );
}

Widget menueDetailMaterial(
    {required List<String> materials,
    required double screenwidth,
    required Widget titlewidget}) {
  Widget menudetail = Column(
    children: [
      titlewidget,
      Column(
        children:
            makeTextList(materials, screenwidth, const TextStyle(fontSize: 15)),
      ),
    ],
  );
  return menudetail;
}
///----------------make text list widget----------------------
///
