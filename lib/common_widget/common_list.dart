///package~
import 'package:flutter/material.dart';
import 'package:phoenix/common_widget/common_tile.dart';

class CommonList extends StatefulWidget {
  final Function delete;
  final Widget titleWidget;
  final String title;
  final List<String> materials;
  final double width;
  final TextStyle textstyle;
  final String initialValue;
  final bool dispalyButton;

  CommonList(
      {this.initialValue = "",
      required this.dispalyButton,
      required this.delete,
      required this.titleWidget,
      required this.title,
      required this.width,
      required this.materials,
      required this.textstyle});

  @override
  _CommonListState createState() => _CommonListState();
}

class _CommonListState extends State<CommonList> {
  @override
  Widget build(BuildContext context) {
    return menueDetailMaterial();
  }

  List<Widget> _makelist() {
    List<Widget> tiles = [];
    if (widget.materials.isEmpty ||
        (widget.title == "レシピ名" && widget.materials[0] == "")) {
      if (widget.initialValue != "") {
        return [
          CommonTitle(
              title: widget.title,
              text: widget.initialValue,
              width: widget.width,
              textstyle: widget.textstyle,
              delete: () {})
        ];
      } else {
        return [];
      }
    }

    for (String name in widget.materials) {
      tiles.add(CommonTitle(
          needButton: widget.dispalyButton,
          title: widget.title,
          text: name,
          width: widget.width,
          textstyle: widget.textstyle,
          delete: widget.delete));
    }

    return tiles;
  }

  Widget menueDetailMaterial() {
    Widget menudetail = Column(
      children: [
        widget.titleWidget,
        Column(children: _makelist()),
      ],
    );
    return menudetail;
  }
}
