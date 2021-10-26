// packages
import 'package:flutter/material.dart';

Widget _showlisttile(String text, double width, TextStyle textstyle) {
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