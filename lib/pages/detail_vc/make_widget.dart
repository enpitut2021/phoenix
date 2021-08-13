import 'package:flutter/material.dart';
import '../../recipe/recipes.dart';
import '../../common_widget/makelist.dart';

Widget _menuDetailMaterial(
    {required String title,
    required List<String> materials,
    required double screenwidth}) {
  Widget menudetail = Column(
    children: [
      Card(
        child: Container(
          color: Colors.orange.shade200,
          width: screenwidth,
          child: Text(
            title,
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ),
      Column(
        children:
            makeTextList(materials, screenwidth, const TextStyle(fontSize: 15)),
      ),
    ],
  );
  return menudetail;
}

Widget setMenue(Recipe recipe, Size screenSize) {
  return Flexible(
    child: ListView(
      shrinkWrap: true,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _menuDetailMaterial(
                title: '材料',
                materials: recipe.toFoodstuffs(recipe.ingredients),
                screenwidth: screenSize.width / 2.2),
            _menuDetailMaterial(
                title: '調味料',
                materials: recipe.toFoodstuffs(recipe.spices),
                screenwidth: screenSize.width / 2.2),
          ],
        ),
        Card(
          child: Container(
            color: Colors.orange.shade200,
            width: screenSize.width,
            child: const Text(
              '作り方',
              style: TextStyle(fontSize: 24),
            ),
          ),
        ),
        //この部分を箇条書き/文章形式に
        Text(recipe.explain),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _menuDetailMaterial(
                title: '調理器具',
                materials: recipe.cookwares,
                screenwidth: screenSize.width / 2.2),
            _menuDetailMaterial(
                title: '調理方法',
                materials: recipe.cookmethod,
                screenwidth: screenSize.width / 2.2),
          ],
        ),
      ],
    ),
  );
}
