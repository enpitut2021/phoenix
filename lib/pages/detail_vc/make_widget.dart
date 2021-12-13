import 'package:flutter/material.dart';
import 'package:phoenix/Model/recipe/recipe_models.dart';
import '../../common_widget/makelist.dart';

Widget _recipeField({required double screenwidth, required String title}) {
  return (Card(
    child: Container(
      color: Colors.orange.shade200,
      width: screenwidth,
      child: Text(
        title,
        style: const TextStyle(fontSize: 24),
      ),
    ),
  ));
}

Widget setMenue(Recipe recipe, Size screenSize) {
  return Flexible(
    child: ListView(
      shrinkWrap: true,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            menueDetailMaterial(
                materials: recipe.toFoodstuffs(recipe.ingredients),
                screenwidth: screenSize.width / 2.1,
                titlewidget: _recipeField(
                    screenwidth: screenSize.width / 2.1, title: '材料')),
            menueDetailMaterial(
                materials: recipe.toFoodstuffs(recipe.spices),
                screenwidth: screenSize.width / 2.1,
                titlewidget: _recipeField(
                    screenwidth: screenSize.width / 2.1, title: '調味料')),
          ],
        ),
        menueDetailMaterial(
            materials: recipe.explain,
            screenwidth: screenSize.width,
            titlewidget:
                _recipeField(screenwidth: screenSize.width, title: '作り方')),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            menueDetailMaterial(
                materials: recipe.cookwares,
                screenwidth: screenSize.width / 2.1,
                titlewidget: _recipeField(
                    screenwidth: screenSize.width / 2.1, title: '調理器具')),
            menueDetailMaterial(
                materials: recipe.cookmethod,
                screenwidth: screenSize.width / 2.1,
                titlewidget: _recipeField(
                    screenwidth: screenSize.width / 2.1, title: '調理方法')),
          ],
        ),
      ],
    ),
  );
}
