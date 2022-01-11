import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:phoenix/Model/recipe/recipe_models.dart';
import 'package:phoenix/common_widget/alert_action.dart';
import 'package:phoenix/common_widget/image_operation.dart';
import 'package:phoenix/pages/upload_recipe/upload_body.dart';

import '../../common_widget/time_represent.dart';

class RecepiEditPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("編集画面"),
      ),
      body: RecipeEditBody(),
    );
  }
}

class RecipeEditBody extends StatefulWidget {
  @override
  _RecipeEditBodyState createState() => _RecipeEditBodyState();
}

class _RecipeEditBodyState extends State<RecipeEditBody> {
  late Recipe recipe;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    recipe =
        (ModalRoute.of(context)!.settings.arguments as RecipeArgument).recipe;
    return Column(children: <Widget>[_setBody(width), updateButton(width)]);
  }

  Widget _setBody(double width) {
    return Flexible(
      child: ListView(
        children: <Widget>[
          //画像
          Stack(
            alignment: Alignment.bottomRight,
            children: <Widget>[
              Container(
                child: Image.network(
                  recipe.imageurl,
                  width: width,
                  height: width * (2 / 3),
                  fit: BoxFit.cover,
                ),
                // width: width,
                // height: width / 2,
              ),
              Container(
                child: timeDropdownButtun(_updateTime, "調理時間"),
                color: Colors.orange.shade400,
              ),
            ],
          ),

          UpLoadList("レシピ名", _updaterecipe, _deleteCategory,
              [recipe.recipename], width, "(例)卵焼き"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              UpLoadList(
                  "材料",
                  _updaterecipe,
                  _deleteCategory,
                  recipe.toFoodstuffs(recipe.ingredients),
                  width / 2.05,
                  "(例)卵 1個"),
              UpLoadList(
                  "調味料",
                  _updaterecipe,
                  _deleteCategory,
                  recipe.toFoodstuffs(recipe.spices),
                  width / 2.05,
                  "(例)醤油 小さじ1"),
            ],
          ),
          UpLoadList("説明", _updaterecipe, _deleteCategory, recipe.explain,
              width, "(例)卵を溶く"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              UpLoadList("調理器具", _updaterecipe, _deleteCategory,
                  recipe.cookwares, width / 2.05, "(例)フライパン"),
              UpLoadList("調理方法", _updaterecipe, _deleteCategory,
                  recipe.cookmethod, width / 2.05, "(例)焼く"),
            ],
          ),
        ],
      ),
    );
  }

  Widget updateButton(double width) {
    return Container(
      child: ElevatedButton(
          child: const Text('変更を保存する'),
          onPressed: () {
            recipe.updateRecipe();
            Navigator.pop(context);
            Navigator.pop(context);
          }),
      width: width,
    );
  }

  //update recipe data
  void _updaterecipe(
      {required String title, required String name, required String amount}) {
    setState(() {
      print(title);
      if (title == "レシピ名") {
        recipe.recipename = name;
      } else if (title == "材料") {
        recipe.ingredients.add(Foodstuff(name: name, amount: amount));
      } else if (title == "調味料") {
        recipe.spices.add(Foodstuff(name: name, amount: amount));
      } else if (title == "説明") {
        recipe.explain.add(name);
      } else if (title == "調理器具") {
        recipe.cookwares.add(name);
      } else if (title == "調理方法") {
        recipe.cookmethod.add(name);
      }
    });
  }

  void _updateTime({required time}) {
    recipe.time = time;
  }

  void _deleteCategory({required String title, required String name}) {
    setState(() {
      if (title == "材料") {
        recipe.ingredients.removeWhere(
            (element) => recipe.toFoodstuffs([element])[0] == name);
      } else if (title == "調味料") {
        recipe.spices.removeWhere(
            (element) => recipe.toFoodstuffs([element])[0] == name);
      } else if (title == "説明") {
        recipe.explain.remove(name);
      } else if (title == "調理器具") {
        recipe.cookwares.remove(name);
      } else if (title == "調理方法") {
        recipe.cookmethod.remove(name);
      }
    });
  }
}
