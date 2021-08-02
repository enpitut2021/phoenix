import 'package:flutter/material.dart';
import '../recipe/Recipes.dart';
import './makeWidget.dart';

class DetailOfMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final args = ModalRoute.of(context)!.settings.arguments
        as RecipeArgument; //type is Recipe

    return Scaffold(
      appBar: AppBar(
        title: Text(args.recipe.recipe_name),
      ),
      body: ListView(
        children: <Widget>[
          //
          //写真
          //
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              menuDetailMaterial(
                  title: '材料',
                  materials: args.recipe.ingredients,
                  screenwidth: screenSize.width / 2.2),
              menuDetailMaterial(
                  title: '調味料',
                  materials: args.recipe.spices,
                  screenwidth: screenSize.width / 2.2),
            ],
          ),
          Card(
            child: Container(
              color: Colors.orange.shade200,
              width: screenSize.width,
              child: Text(
                '作り方',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
          //この部分を箇条書き/文章形式に
          Text(args.recipe.explain),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              menuDetailObjects(
                  title: '調理器具',
                  objects: args.recipe.cookwares,
                  screenwidth: screenSize.width / 2.2),
              menuDetailObjects(
                  title: '調理方法',
                  objects: args.recipe.cookmethod,
                  screenwidth: screenSize.width / 2.2),
            ],
          ),
        ],
      ),
    );
  }
}

// Widget menuDetailMaterial(
//     {required String title,
//     required List<material> materials,
//     required double screenwidth}) {
//   Widget menudetail = Column(
//     children: [
//       Card(
//         child: Container(
//           color: Colors.orange.shade200,
//           width: screenwidth,
//           child: Text(
//             title,
//             style: TextStyle(fontSize: 24),
//           ),
//         ),
//       ),
//       Column(
//         children: displayMaterial(materials, screenwidth),
//       ),
//     ],
//   );
//   return menudetail;
// }

// List<Widget> displayMaterial(List<material> foodstuffs, double width) {
//   List<Widget> materials = [];
//   for (var foodstuff in foodstuffs) {
//     materials.add(_tileFoodstuff(foodstuff, width));
//   }
//   return materials;
// }

// Widget _tileFoodstuff(material foodstuff, double width) {
//   return Container(
//     child: Text(
//       foodstuff.name + " " + foodstuff.amount,
//       style: const TextStyle(fontSize: 15),
//     ),
//     width: width,
//     margin: EdgeInsets.all(2),
//     decoration: BoxDecoration(
//       border: Border.all(color: Colors.white10, width: 1),
//     ),
//   );
// }

// Widget menuDetailObjects(
//     {required String title,
//     required List<String> objects,
//     required double screenwidth}) {
//   Widget menudetail = Column(
//     children: [
//       Card(
//         child: Container(
//           color: Colors.orange.shade200,
//           width: screenwidth,
//           child: Text(
//             title,
//             style: TextStyle(fontSize: 24),
//           ),
//         ),
//       ),
//       Column(
//         children: displayObjects(objects, screenwidth),
//       ),
//     ],
//   );
//   return menudetail;
// }

// List<Widget> displayObjects(List<String> objects, double width) {
//   List<Widget> temp = [];
//   for (var object in objects) {
//     temp.add(_tileobject(object, width));
//   }
//   return temp;
// }

// Widget _tileobject(String object, double width) {
//   return Container(
//     child: Text(
//       object,
//       style: const TextStyle(fontSize: 15),
//     ),
//     width: width,
//     margin: EdgeInsets.all(2),
//     decoration: BoxDecoration(
//       border: Border.all(color: Colors.white10, width: 1),
//     ),
//   );
// }
