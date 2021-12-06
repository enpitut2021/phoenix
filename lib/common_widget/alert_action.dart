import 'package:flutter/material.dart';

class ButtonAction {
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

class ErrorAction {
  static Future<String> errorMessage(BuildContext context, String message) {
    String errorMessage = "empty_error";
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(message),
              actions: <Widget>[
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: const Text("はい"),
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
    return Future<String>.value(errorMessage);
  }
}
