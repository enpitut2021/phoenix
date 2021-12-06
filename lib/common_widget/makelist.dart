///package~
import 'package:flutter/material.dart';

///----------------make text list widget---------------------
List<Widget> makeTextList(
    List<String> texts, double width, TextStyle textstyle) {
  List<Widget> lists = [];
  if (texts.isEmpty) {
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

List<Widget> makedeletableList(
  List<String> texts, double width, TextStyle textstyle, Function ontap) {
  List<Widget> lists = [];
  if (texts.isEmpty) {
    lists.add(_tile('', width, textstyle));
  }

  for (var text in texts) {
    lists.add(_deletabletile(text, width, textstyle, () {
      ontap((){texts.remove(text);});
      print(ontap.toString());
      print(texts);
    }));
  }
  return lists;
}

Widget _deletabletile(String text, double width, TextStyle textstyle, Function onTap) {
  return Container(
    child: ListTile(
      title : Text(
        text,
        style: textstyle,
      ),
      tileColor: Colors.orange.shade100,
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: (){onTap();},
      ),
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

Widget makeChangeableMaterialList(
    {required List<String> materials,
    required double screenwidth,
    required Widget titlewidget,
    required Function onTap
    }) {
  Widget menudetail = Column(
    children: [
      titlewidget,
      Column(
        children : makedeletableList(materials, screenwidth, const TextStyle(fontSize: 15), onTap),
      ),
    ],
  );
  return menudetail;
}
///----------------make text list widget----------------------
///
