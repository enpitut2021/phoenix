import 'package:flutter/material.dart';

class CommonTitle extends StatefulWidget {
  final bool needButton;
  final String title;
  final String text;
  final double width;
  final TextStyle textstyle;
  final Function delete;

  CommonTitle(
      {this.needButton = false,
      required this.title,
      required this.text,
      required this.width,
      required this.textstyle,
      required this.delete});
  @override
  _CommonTileState createState() => _CommonTileState();
}

class _CommonTileState extends State<CommonTitle> {
  @override
  Widget build(BuildContext context) {
    if (!widget.needButton || widget.title == "レシピ名") {
      return tileNoButton();
    } else {
      return tileWithButton();
    }
  }

  Widget tileNoButton() {
    return Container(
      child: ListTile(
        title: Text(
          widget.text,
          style: widget.textstyle,
        ),
        tileColor: Colors.orange.shade100,
      ),
      width: widget.width,
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white10, width: 1),
      ),
    );
  }

  Widget tileWithButton() {
    return Container(
      child: ListTile(
        title: Text(
          widget.text,
          style: widget.textstyle,
        ),
        tileColor: Colors.orange.shade100,
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            widget.delete(title: widget.title, name: widget.text);
          },
        ),
      ),
      width: widget.width,
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white10, width: 1),
      ),
    );
  }
}
