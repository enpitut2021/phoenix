import 'package:flutter/material.dart';

class buttonAction {
  Future<String> buttonPressed(context) {
    String addword = "";
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('リストに追加'),
              actions: <Widget>[
                TextFormField(
                  onFieldSubmitted: (String str) {
                    addword = str;
                  },
                ),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: const Text("追加"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
    return Future<String>.value(addword);
  }
}
