import 'package:flutter/material.dart';

class timeDropdownButtun extends StatefulWidget {
  final String title;
  Function addtion;
  timeDropdownButtun(this.addtion, this.title);

  @override
  _timeDropdownButtunState createState() => _timeDropdownButtunState();
}

class _timeDropdownButtunState extends State<timeDropdownButtun> {
  List<DropdownMenuItem<int>> _items = [];
  int _selection = 0;

  @override
  void initState() {
    super.initState();
    setItem();
    _selection = _items[0].value!;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      items: _items,
      value: _selection,
      dropdownColor: Colors.orange.shade100,
      onChanged: (int? value) => {
        setState(() {
          _selection = value!;
          widget.addtion(time: _selection);
        }),
      },
    );
  }

  void setItem() {
    for (int i = 0; i <= 60; i++) {
      if (i == 0) {
        _items.add(DropdownMenuItem(
          child: Center(child: Text(widget.title)),
          value: 100,
        ));
      } else if (i == 60) {
        _items.add(DropdownMenuItem(
          child: Center(
              child: Text(
            i.toString() + "+分",
          )),
          value: i,
        ));
      } else if ((i > 0 && i <= 10) ||
          ((i <= 30) && i % 5 == 0) ||
          i % 10 == 0) {
        _items.add(DropdownMenuItem(
          child: Center(
              child: Text(
            i.toString() + "分",
          )),
          value: i,
        ));
      }
    }
  }
}

Widget time_widget(int time) {
  if (time == 60) {
    return Container(
      child: Text(
        time.toString() + "分",
        style: const TextStyle(fontSize: 24),
      ),
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  } else if (time != 100) {
    return Container(
      child: Text(
        time.toString() + "分",
        style: const TextStyle(fontSize: 24),
      ),
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  } else {
    return Container(
      child: Text(
        "未設定",
        style: const TextStyle(fontSize: 24),
      ),
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
