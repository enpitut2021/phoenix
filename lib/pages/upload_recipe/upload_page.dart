import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:phoenix/Model/recipe/recipe_models.dart';
import 'package:phoenix/common_widget/alert_action.dart';
import 'package:phoenix/common_widget/image_operation.dart';
import 'package:phoenix/pages/upload_recipe/upload_body.dart';

class NewUploadVC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("投稿画面"),
      ),
      body: UpLoadBody(),
    );
  }
}

class UpLoadBody extends StatefulWidget {
  @override
  _UpLoadBodyState createState() => _UpLoadBodyState();
}

class _UpLoadBodyState extends State<UpLoadBody> {
  File? image;
  Recipe recipe = Recipe(
      id: '',
      recipename: '',
      imageurl: '',
      ingredients: [],
      cookmethod: [],
      cookwares: [],
      explain: [],
      spices: [],
      time: 0);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return _setBody(recipe, width);
  }

  Widget _setBody(Recipe recipe, double width) {
    return ListView(
      children: <Widget>[
        //画像
        Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            NewMyImage(_imageUpdateUrl, width, image),
            Container(
              child: UpLoadTime(_updateTime, "調理時間"),
              color: Colors.orange.shade400,
            ),
          ],
        ),

        UpLoadList(
            "レシピ名", _updaterecipe, _deleteCategory, [recipe.recipename], width),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            UpLoadList("材料", _updaterecipe, _deleteCategory,
                recipe.toFoodstuffs(recipe.ingredients), width / 2.05),
            UpLoadList("調味料", _updaterecipe, _deleteCategory,
                recipe.toFoodstuffs(recipe.spices), width / 2.05),
          ],
        ),
        UpLoadList("説明", _updaterecipe, _deleteCategory, recipe.explain, width),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            UpLoadList("調理器具", _updaterecipe, _deleteCategory, recipe.cookwares,
                width / 2.05),
            UpLoadList("調理方法", _updaterecipe, _deleteCategory,
                recipe.cookmethod, width / 2.05),
          ],
        ),
        ElevatedButton(
            child: const Text('投稿する'),
            onPressed: () {
              if (recipe.imageurl != "") {
                recipe.uploadRecipe().then((value) async {
                  await recipe.upload(value.id, image).then((value) => {
                        recipe.imageurl = value,
                      });
                  await FirebaseFirestore.instance
                      .collection('recipes')
                      .doc(value.id)
                      .update({'imageurl': recipe.imageurl});
                  Navigator.pop(context);
                });
              } else {
                ErrorAction.errorMessage(context, "画像の入力がまだです");
              }
            }),
      ],
    );
  }

  //update recipe data
  void _updaterecipe(
      {required String title, required String name, required String amount}) {
    setState(() {
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

  void _imageUpdateUrl({required String url, required File image}) {
    // setState(() {
    recipe.imageurl = url;
    this.image = image;
    print(recipe.imageurl);
    // });
  }
}
