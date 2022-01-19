///dart~
import 'dart:async';
import 'dart:convert';

///package~
import 'package:flutter/services.dart' show rootBundle;
import 'package:cloud_firestore/cloud_firestore.dart';

//my library
import 'recipe_models.dart';

class LoadRecipes {
  static Future<dynamic> loadFirestoreAsset() async {
    Recipes recipes = Recipes(recipes: []);
    final QuerySnapshot _loadData =
        await FirebaseFirestore.instance.collection('recipes').get();

    for (final _data in _loadData.docs) {
      Recipe recipe =
          _reconstructRecipe(_data as DocumentSnapshot<Map<String, dynamic>>);
      recipes.add(recipe: recipe);
    }
    return recipes;
  }

  static Future<Recipe> loadFirestoreAssetAt(String recipeId) async {
    Recipe _recipe;
    final recipeDoc = await FirebaseFirestore.instance
        .collection('recipes')
        .doc(recipeId)
        .get();

    _recipe = _reconstructRecipe(recipeDoc);

    return Future<Recipe>.value(_recipe);
  }

  static Recipe _reconstructRecipe(
      DocumentSnapshot<Map<String, dynamic>> _data) {
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

    int time = _data['time'];

    Recipe recipe = Recipe(
      id: _data.id,
      recipename: _data['recipe_name'],
      imageurl: _data['imageurl'],
      ingredients: ingredients,
      spices: spices,
      explain: explain,
      cookwares: cookwares,
      cookmethod: cookmethod,
      time: time,
    );
    return recipe;
  }

  static Future<dynamic> loadJsonAsset() async {
    Recipes recipes = Recipes(recipes: []);
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
      //調理時間
      int time = 0;
      // for (var cm in element["time"]) {
      //   cookmethod.add(cm);
      // }
      //レシピの作成
      Recipe recipe = Recipe(
          id: element['id'],
          imageurl: element['image'],
          recipename: element['recipe_name'],
          explain: ["aaaaa", "bbbbb", "cccc"],
          ingredients: ingredients,
          spices: spices,
          cookwares: cookwares,
          cookmethod: cookmethod,
          time: time);

      recipes.add(recipe: recipe);
    }
    return recipes;
  }
}
