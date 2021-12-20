import 'package:flutter/material.dart';

// abstract class CommonTileInterface {
//   String text;
//   double width;
//   TextStyle textstyle;
//   CommonTileInterface(
//       {required this.text, required this.width, required this.textstyle});
//
//   Widget build(BuildContext context, void Function()? onPressed);
// }

class CommonTile {
  String title;
  String text;
  double width;
  TextStyle textstyle;
  CommonTile(
      {required this.title,
      required this.text,
      required this.width,
      required this.textstyle});

  Widget build({void Function()? onPress}) {
    if (onPress == null) {
      return tileNoButton();
    } else {
      return tileWithButton(onPress);
    }
  }

  Widget tileNoButton() {
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

  Widget tileWithButton(void Function()? onPress) {
    if (title != "レシピ名") {
      return Container(
        child: ListTile(
          title: Text(
            text,
            style: textstyle,
          ),
          tileColor: Colors.orange.shade100,
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: onPress,
          ),
        ),
        width: width,
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white10, width: 1),
        ),
      );
    } else {
      return Container(
        child: ListTile(
          title: Text(
            text,
            style: textstyle,
          ),
          tileColor: Colors.orange.shade100,
        ),
        width: width,
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white10, width: 1),
        ),
      );
    }
  }

  // Widget build(String text, double width, TextStyle textstyle,
  //     {int? tileindex}) {
  // if (tileindex >= 0 && widget.title != "レシピ名") {
  //   return Container(
  //     child: ListTile(
  //       title: Text(
  //         text,
  //         style: textstyle,
  //       ),
  //       tileColor: Colors.orange.shade100,
  //       trailing: IconButton(
  //         icon: const Icon(Icons.delete),
  //         onPressed: () {
  //           widget.delete(title: widget.title, name: text);
  //         },
  //       ),
  //     ),
  //     width: width,
  //     margin: const EdgeInsets.all(2),
  //     decoration: BoxDecoration(
  //       border: Border.all(color: Colors.white10, width: 1),
  //     ),
  //   );
  // } else {
  //   return Container(
  //     child: ListTile(
  //       title: Text(
  //         text,
  //         style: textstyle,
  //       ),
  //       tileColor: Colors.orange.shade100,
  //     ),
  //     width: width,
  //     margin: const EdgeInsets.all(2),
  //     decoration: BoxDecoration(
  //       border: Border.all(color: Colors.white10, width: 1),
  //     ),
  //   );
  // }
  // }
}
