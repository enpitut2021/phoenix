///package~
import 'package:flutter/material.dart';
import 'package:phoenix/common_widget/common_tile.dart';

class CommonList extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return menueDetailMaterial();
  }

  List<Widget> _makelist() {
    List<Widget> tiles = [];
    if (materials.isEmpty || (title == "レシピ名" && materials[0] == "")) {
      if (initialValue != "") {
        return [
          CommonTitle(
              title: title,
              text: initialValue,
              width: width,
              textstyle: textstyle,
              delete: () {})
        ];
      } else {
        return [];
      }
    }

    for (String name in materials) {
      tiles.add(CommonTitle(
          needButton: dispalyButton,
          title: title,
          text: name,
          width: width,
          textstyle: textstyle,
          delete: delete));
    }

    return tiles;
  }

  Widget menueDetailMaterial() {
    Widget menudetail = Column(
      children: [
        titleWidget,
        Column(children: _makelist()),
      ],
    );
    return menudetail;
  }
}
