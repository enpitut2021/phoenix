import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../data/toolsForList.dart';

class Recipes {
  List<Recipe> recipes = [];
  Recipes({required this.recipes});

  Recipes filterRecipe({required List<String> contains}) {
    Recipes filteredRecipes = Recipes(recipes: []);
    List<String> ids = [];

    //制約をかける前
    if (contains.length == 0) {
      return this;
    }

    for (var contein in contains) {
      final tmp = recipes.where((recipe) =>
          (recipe.hasIngredient(searchWord: contein) &&
              !recipe.aleadyExist(ids)));
      for (var obj in tmp) {
        filteredRecipes.add(recipe: obj);
        ids.add(obj.id);
      }
    }
    return filteredRecipes;
  }

  void add({required Recipe recipe}) {
    recipes.add(recipe);
  }

  void clear() {
    recipes.clear();
  }

  void remove({required int at}) {
    recipes.removeAt(at);
  }
}

class Recipe {
  String id = "";
  String imageUrl = "";
  String recipe_name = "";
  String explain = "";
  List<material> ingredients = [];
  List<material> spices = [];
  List<String> cookwares = [];
  List<String> cookmethod = [];

  Recipe(
      {required this.id,
      required this.imageUrl,
      required this.recipe_name,
      required this.explain,
      required this.ingredients,
      required this.spices,
      required this.cookwares,
      required this.cookmethod});

  bool hasIngredient({required String searchWord}) {
    var tmp = this
        .ingredients
        .where((element) => katakanaToHira(element.name).contains(searchWord));
    return !tmp.isEmpty;
  }

  bool hasSpice({required String searchWord}) {
    var tmp = this
        .spices
        .where((element) => katakanaToHira(element.name).contains(searchWord));
    return !tmp.isEmpty;
  }

  bool aleadyExist(List<String> ids) {
    final tmp = ids.where((id) => this.id == id);
    return tmp.length != 0;
  }
}

class material {
  //ingredient or spice
  String name = "";
  String amount = "";

  material({required this.name, required this.amount});
}

class RecipeArgument {
  Recipe recipe;
  RecipeArgument(this.recipe);
}
