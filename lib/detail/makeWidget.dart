import 'package:flutter/material.dart';
import '../recipe/Recipes.dart';

Widget menuDetailMaterial(
    {required String title,
    required List<material> materials,
    required double screenwidth}) {
  Widget menudetail = Column(
    children: [
      Card(
        child: Container(
          color: Colors.orange.shade200,
          width: screenwidth,
          child: Text(
            title,
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
      Column(
        children: displayMaterial(materials, screenwidth),
      ),
    ],
  );
  return menudetail;
}

List<Widget> displayMaterial(List<material> foodstuffs, double width) {
  List<Widget> materials = [];
  for (var foodstuff in foodstuffs) {
    materials.add(_tileFoodstuff(foodstuff, width));
  }
  return materials;
}

Widget _tileFoodstuff(material foodstuff, double width) {
  return Container(
    child: Text(
      foodstuff.name + " " + foodstuff.amount,
      style: const TextStyle(fontSize: 15),
    ),
    width: width,
    margin: EdgeInsets.all(2),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.white10, width: 1),
    ),
  );
}

Widget menuDetailObjects(
    {required String title,
    required List<String> objects,
    required double screenwidth}) {
  Widget menudetail = Column(
    children: [
      Card(
        child: Container(
          color: Colors.orange.shade200,
          width: screenwidth,
          child: Text(
            title,
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
      Column(
        children: displayObjects(objects, screenwidth),
      ),
    ],
  );
  return menudetail;
}

List<Widget> displayObjects(List<String> objects, double width) {
  List<Widget> temp = [];
  for (var object in objects) {
    temp.add(_tileobject(object, width));
  }
  return temp;
}

Widget _tileobject(String object, double width) {
  return Container(
    child: Text(
      object,
      style: const TextStyle(fontSize: 15),
    ),
    width: width,
    margin: EdgeInsets.all(2),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.white10, width: 1),
    ),
  );
}
