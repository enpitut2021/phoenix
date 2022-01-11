import 'package:flutter/material.dart';
import 'package:phoenix/common_widget/common_list.dart';

class UpLoadList extends StatefulWidget {
  final String title;
  final String initialLabel;
  final Function addtion;
  final Function delete;
  final double screenWidth;
  final bool displayAddButton;
  List<String> elements;

  UpLoadList(this.title, this.addtion, this.delete, this.elements,
      this.screenWidth, this.initialLabel,
      {this.displayAddButton = true});

  @override
  _UpLoadListState createState() => _UpLoadListState();
}

class _UpLoadListState extends State<UpLoadList> {
  String name = "";
  String amount = "";

  @override
  Widget build(BuildContext context) {
    return CommonList(
        delete: widget.delete,
        titleWidget: _title(widget.title),
        title: widget.title,
        width: widget.screenWidth,
        materials: widget.elements,
        textstyle: const TextStyle(fontSize: 15),
        initialValue: widget.initialLabel,
        dispalyButton: widget.displayAddButton);
  }

  Widget _title(String text) {
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
          if (widget.displayAddButton) _addButton(),
        ],
      ),
    );
  }

  Widget _addButton() {
    return Container(
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
          _makedialog();
        },
      ),
      alignment: Alignment.bottomRight,
    );
  }

  void _makedialog() {
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

  bool _isFoodstuf() {
    final title = widget.title;
    if (title == "材料" || title == "調味料") {
      return true;
    } else {
      return false;
    }
  }
}
