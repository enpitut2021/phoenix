import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phoenix/common_widget/makelist.dart';
import 'package:phoenix/recipe/recipe_models.dart';

Widget _labelWithButton(String text, double width) {
  return SizedBox(
    width: width,
    height: 40,
    child: Stack(
      children: <Widget>[
        Container(
          child: Text(text),
          alignment: Alignment.center,
          color: Colors.orange,
        ),
        Container(
          child: ElevatedButton(
            child: const Icon(Icons.add),
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              shape: const CircleBorder(
                side: BorderSide(
                  color: Colors.black,
                  width: 1,
                  style: BorderStyle.solid,
                ),
              ),
            ),
            onPressed: () {
              print("Hello" + text);
            },
          ),
          alignment: Alignment.bottomRight,
        ),
      ],
    ),
  );
}

Widget setRecipe({required Size screenSize, required Recipe recipe}) {
  return Column(
    children: [
      // 画像,
      _labelWithButton('レシピの名前', screenSize.width),
      Text(recipe.recipename),
      Row(
        children: <Widget>[
          menueDetailMaterial(
              materials: recipe.toFoodstuffs(recipe.ingredients),
              screenwidth: screenSize.width / 2.2,
              titlewidget: _labelWithButton('材料', screenSize.width / 2)),
          menueDetailMaterial(
              materials: recipe.toFoodstuffs(recipe.spices),
              screenwidth: screenSize.width / 2.2,
              titlewidget: _labelWithButton('調味料', screenSize.width / 2)),
        ],
      ),
      menueDetailMaterial(
          materials: recipe.explain,
          screenwidth: screenSize.width / 2,
          titlewidget: _labelWithButton('説明', screenSize.width)),
      Row(
        children: <Widget>[
          menueDetailMaterial(
              materials: recipe.cookwares,
              screenwidth: screenSize.width / 2.2,
              titlewidget: _labelWithButton('調理器具', screenSize.width / 2)),
          menueDetailMaterial(
              materials: recipe.cookmethod,
              screenwidth: screenSize.width / 2.2,
              titlewidget: _labelWithButton('調理方法', screenSize.width / 2)),
          // _labelWithButton('調理方法', screenSize.width / 2),
          // Column(
          //   children: makeTextList(recipe.cookmethod, screenSize.width / 2,
          //       const TextStyle(fontSize: 15)),
          // ),
        ],
      ),
      ElevatedButton(
        child: const Text('投稿する'),
        onPressed: () {},
      ),
    ],
  );
}
