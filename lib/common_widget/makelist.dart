///package~
import 'package:flutter/material.dart';

///----------------make text list widget---------------------
List<Widget> makeTextList(
    List<String> texts, double width, TextStyle textstyle) {
  List<Widget> lists = [];
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
///----------------make text list widget----------------------
///
