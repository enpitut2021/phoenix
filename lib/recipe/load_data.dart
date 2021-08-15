///dart~
import 'dart:async';
import 'dart:convert';

///package~
import 'package:flutter/services.dart' show rootBundle;
//my library
import 'recipe_models.dart';

class LoadRecipes {
  Recipes recipes = Recipes(recipes: []);

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
          explain: element['explain'],
          ingredients: ingredients,
          spices: spices,
          cookwares: cookwares,
          cookmethod: cookmethod);

      recipes.add(recipe: recipe);
    }
    return recipes;
  }
}
