///dart~
import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';

///package~
import 'package:flutter/services.dart' show rootBundle;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

//my library
import 'recipe_models.dart';

class LoadRecipes {
  Recipes recipes = Recipes(recipes: []);

  Future<dynamic> loadFirestoreAsset() async {
    final QuerySnapshot _loadData =
        await FirebaseFirestore.instance.collection('recipes').get();

    for (final _data in _loadData.docs) {
      List<Foodstuff> ingredients = [];
      for (var element in _data['ingredients']) {
        ingredients.add(Foodstuff(
          name: element['ingredient'],
          amount: element['quantity'],
        ));
      }
      List<Foodstuff> spices = [];
      for (var element in _data['spices']) {
        spices.add(Foodstuff(
          name: element['spice'],
          amount: element['amount'],
        ));
      }

      List<String> explain = [];
      for (var element in _data['explain']) {
        explain.add(element.toString());
      }

      List<String> cookwares = [];
      for (var element in _data['cookwares']) {
        cookwares.add(element.toString());
      }

      List<String> cookmethod = [];
      for (var element in _data['method']) {
        cookmethod.add(element.toString());
      }

      Recipe recipe = Recipe(
        id: _data['id'].toString(),
        recipename: _data['recipe_name'],
        //imageurl: _data['imageurl'],
        imageurl: "lib/recipe/images/test1.jpeg",
        ingredients: ingredients,
        spices: spices,
        explain: explain,
        cookwares: cookwares,
        cookmethod: cookmethod,
      );
      recipes.add(recipe: recipe);
    }
    return recipes;
    /*
    StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('recipes').snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          print(Text(snapshot.data('recipe_name')));
          return Text(snapshot.data('recipe_name'));
        });
    */
    /*
    await FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('recipes').get(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            final List<DocumentSnapshot> _loadData = snapshot.data!.docs;
            _loadData.map((_data) {
              Recipe recipe = Recipe(
                id: _data['id'],
                recipename: _data['recipe_name'],
                imageurl: _data['image'],
                ingredients: _data['ingredients'],
                spices: _data['spices'],
                explain: _data['explain'],
                cookwares: _data['cookwares'],
                cookmethod: _data['Cooking_method'],
              );
              recipes.add(recipe: recipe);
            });
            return Text(snapshot.data);
          }
          return Center(
            child: Text('読み込み中'),
          );
        });
    return recipes;
    */
  }

  Future<dynamic> loadJsonAsset() async {
    final String _loadData =
        await rootBundle.loadString('lib/recipe/recipe.json');
    final jsonResponse = json.decode(_loadData);

    for (var element in jsonResponse["recipes"]) {
      //材料の情報を作成
      List<Foodstuff> ingredients = [];
      for (var ingredient in element["ingredients"]) {
        ingredients.add(Foodstuff(
            name: ingredient["ingredient"], amount: ingredient["quantity"]));
      }
      //調味料の情報を作成
      List<Foodstuff> spices = [];
      for (var spice in element["spices"]) {
        // print(spice["spice"] + " " + spice["amount"]);
        spices.add(Foodstuff(name: spice["spice"], amount: spice["amount"]));
      }
      //調理器具の作成
      List<String> cookwares = [];
      for (var cookware in element["cookwares"]) {
        cookwares.add(cookware);
      }
      //調理方法
      List<String> cookmethod = [];
      for (var cm in element["Cooking_method"]) {
        cookmethod.add(cm);
      }
      //レシピの作成
      Recipe recipe = Recipe(
          id: element['id'],
          imageurl: element['image'],
          recipename: element['recipe_name'],
          explain: ["aaaaa", "bbbbb", "cccc"],
          ingredients: ingredients,
          spices: spices,
          cookwares: cookwares,
          cookmethod: cookmethod);

      recipes.add(recipe: recipe);
    }
    return recipes;
  }
}
