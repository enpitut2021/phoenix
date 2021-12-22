import 'package:flutter/material.dart';
import 'package:phoenix/Model/recipe/recipe_models.dart';
import 'package:phoenix/pages/upload_recipe/upload_body.dart';

Widget setMenue(Recipe recipe, Size screenSize) {
  return Flexible(
    child: ListView(
      shrinkWrap: true,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            UpLoadList(
                "材料",
                () {},
                () {},
                recipe.toFoodstuffs(recipe.ingredients),
                screenSize.width / 2.05,
                "",
                displayAddButton: false),
            UpLoadList("調味料", () {}, () {}, recipe.toFoodstuffs(recipe.spices),
                screenSize.width / 2.05, "",
                displayAddButton: false),
          ],
        ),
        UpLoadList("作り方", () {}, () {}, recipe.explain, screenSize.width, "",
            displayAddButton: false),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            UpLoadList("調理器具", () {}, () {}, recipe.cookwares,
                screenSize.width / 2.05, "",
                displayAddButton: false),
            UpLoadList("調理方法", () {}, () {}, recipe.cookmethod,
                screenSize.width / 2.05, "",
                displayAddButton: false),
          ],
        ),
      ],
    ),
  );
}
