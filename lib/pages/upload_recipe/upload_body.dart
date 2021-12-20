import 'package:flutter/material.dart';
import 'package:phoenix/common_widget/common_list.dart';
import 'package:phoenix/common_widget/common_tile.dart';

class UpLoadList extends StatefulWidget {
  final String title;
  final String initialLabel;
  final Function addtion;
  final Function delete;
  final double screenWidth;
  List<String> elements;
  UpLoadList(this.title, this.addtion, this.delete, this.elements,
      this.screenWidth, this.initialLabel);

  @override
  _UpLoadListState createState() => _UpLoadListState();
}

class _UpLoadListState extends State<UpLoadList> {
  String name = "";
  String amount = "";

  CommonList list = CommonList();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _setTiles();
    return list.menueDetailMaterial(titlewidget: _title(widget.title, context));
  }

  void _setTiles() {
    for (String name in widget.elements) {
      CommonTile tile = CommonTile(
          title: widget.title,
          text: name,
          width: widget.screenWidth,
          textstyle: const TextStyle(fontSize: 15));
      print(list.tiles.length);
      print("before");
      list.addTiles(
          name, widget.screenWidth, const TextStyle(fontSize: 15), tile,
          onPress: () {
        widget.delete(title: widget.title, name: name);
      });
      print("after" + widget.title);
      print(list.tiles.length);
    }
    print(list.tiles.length);
  }

  Widget _title(String text, BuildContext context) {
    return SizedBox(
      width: widget.screenWidth,
      height: 40,
      child: Stack(
        children: <Widget>[
          Container(
            child: Text(text),
            alignment: Alignment.centerLeft,
            color: Colors.orange,
          ),
          Container(
            child: ElevatedButton(
              child: const Icon(Icons.add),
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                shape: const CircleBorder(
                  side: BorderSide(
                    color: Colors.black,
                    width: 1,
                    style: BorderStyle.solid,
                  ),
                ),
              ),
              onPressed: () {
                _makedialog(context);
              },
            ),
            alignment: Alignment.bottomRight,
          ),
        ],
      ),
    );
  }

  void _makedialog(BuildContext context) {
    List<Widget> displayAddDaialog = _setRecipeDataWidget();
    displayAddDaialog.add(Container(
        width: double.infinity,
        child: ElevatedButton(
          child: const Text("追加"),
          onPressed: () {
            Navigator.pop(context);
          },
        )));

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
                title: Container(
                    child: const Text("追加する内容!!!"),
                    alignment: Alignment.center),
                actions: displayAddDaialog);
          },
        );
      },
    ).then((context) {
      if (!(name == "" || (_isFoodstuf() && amount == ""))) {
        print("update");
        widget.addtion(title: widget.title, name: name, amount: amount);
      }
      name = "";
      amount = "";
    });
  }

  List<Widget> _setRecipeDataWidget() {
    List<Widget> output = <Widget>[
      Container(child: Text(widget.title), alignment: Alignment.centerLeft),
      TextFormField(
        onChanged: (String str) {
          name = str;
        },
      ),
    ];
    if (_isFoodstuf()) {
      output.add(
          Container(child: const Text("分量"), alignment: Alignment.centerLeft));
      output.add(TextFormField(
        onChanged: (String str) {
          amount = str;
        },
      ));
    }
    return output;
  }

  // List<Widget> _makeTextList(
  //     List<String> texts, double width, TextStyle textstyle) {
  //   List<Widget> lists = [];
  //   if (texts.isEmpty) {
  //     lists.add(_tile(widget.initialLabel, width, textstyle, -1));
  //   }

  //   for (int i = 0; i < texts.length; i++) {
  //     lists.add(_tile(texts[i], width, textstyle, i));
  //   }

  //   return lists;
  // }

  // Widget _tile(String text, double width, TextStyle textstyle, int tileindex) {
  //   if (tileindex >= 0 && widget.title != "レシピ名") {
  //     return Container(
  //       child: ListTile(
  //         title: Text(
  //           text,
  //           style: textstyle,
  //         ),
  //         tileColor: Colors.orange.shade100,
  //         trailing: IconButton(
  //           icon: const Icon(Icons.delete),
  //           onPressed: () {
  //             widget.delete(title: widget.title, name: text);
  //           },
  //         ),
  //       ),
  //       width: width,
  //       margin: const EdgeInsets.all(2),
  //       decoration: BoxDecoration(
  //         border: Border.all(color: Colors.white10, width: 1),
  //       ),
  //     );
  //   } else {
  //     return Container(
  //       child: ListTile(
  //         title: Text(
  //           text,
  //           style: textstyle,
  //         ),
  //         tileColor: Colors.orange.shade100,
  //       ),
  //       width: width,
  //       margin: const EdgeInsets.all(2),
  //       decoration: BoxDecoration(
  //         border: Border.all(color: Colors.white10, width: 1),
  //       ),
  //     );
  //   }
  // }

  // Widget _menueDetailMaterial(
  //     {required List<String> materials,
  //     required double screenwidth,
  //     required Widget titlewidget}) {
  //   Widget menudetail = Column(
  //     children: [
  //       titlewidget,
  //       Column(
  //         children: _makeTextList(
  //             materials, screenwidth, const TextStyle(fontSize: 15)),
  //       ),
  //     ],
  //   );
  //   return menudetail;
  // }

  bool _isFoodstuf() {
    final title = widget.title;
    if (title == "材料" || title == "調味料") {
      return true;
    } else {
      return false;
    }
  }
}
