import 'package:flutter/material.dart';

class ButtonAction {
  static Future<String> buttonPressed(context, message) async {
    String addword = "";
    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(message),
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
  static Future<String> errorMessage(
      BuildContext context, String message) async {
    String errorMessage = "empty_error";
    await showDialog(
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

  static Future<bool> woringMessage(
      BuildContext context, String message) async {
    bool yes = true;
    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(
                message,
                textAlign: TextAlign.center,
              ),
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
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: const Text("いいえ"),
                    onPressed: () {
                      yes = false;
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
    return Future<bool>.value(yes);
  }
}
