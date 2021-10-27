// packages
import 'package:flutter/material.dart';

List<Widget> registerListTile(List<int> recipes, double width, TextStyle textstyle, Function()? ontap) {
  List<Widget> output = <Widget>[];
  for(int i=0; i<recipes.length; i++){
    Widget tmp = GestureDetector(onTap: ontap,
        child: Container(
          margin: const EdgeInsets.only(left:20, right:20, top:20),
          child:Text(recipes[i].toString(),style:textstyle),
          color:Colors.orangeAccent,
          alignment: Alignment.center,
        ),
      );
    output.add(tmp);
  }
  // return Container(
  //   child: GestureDetector(
  //   onTap: ontap,
  //   child: Container(
  //     child: Text(
  //       text,
  //       style: textstyle,
  //     ),
  //     width: width,
  //     margin: const EdgeInsets.all(2),
  //     decoration: BoxDecoration(
  //       border: Border.all(color: Colors.white10, width: 1),
  //     ),
  //   ),
  // ),
  // );
  return output;
}