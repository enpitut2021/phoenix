import 'package:flutter/services.dart' show rootBundle;
import 'dart:async';
import 'dart:convert';
import './Recipes.dart';

class LoadRecipes {
  Recipes recipes = Recipes(recipes: []);

  Future<dynamic> loadJsonAsset() async {
    final String _loadData =
        await rootBundle.loadString('lib/recipe/recipe.json');
    final jsonResponse = json.decode(_loadData);

    for (var element in jsonResponse["recipes"]) {
      //材料の情報を作成
      List<material> ingredients = [];
      for (var ingredient in element["ingredients"]) {
        ingredients.add(material(
            name: ingredient["ingredient"], amount: ingredient["quantity"]));
      }
      //調味料の情報を作成
      List<material> spices = [];
      for (var spice in element["spices"]) {
        // print(spice["spice"] + " " + spice["amount"]);
        spices.add(material(name: spice["spice"], amount: spice["amount"]));
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
          imageUrl: element['image'],
          recipe_name: element['recipe_name'],
          explain: element['explain'],
          ingredients: ingredients,
          spices: spices,
          cookwares: cookwares,
          cookmethod: cookmethod);

      this.recipes.add(recipe: recipe);
    }
    return this.recipes;
  }
}
