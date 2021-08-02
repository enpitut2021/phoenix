class Recipes {
  List<Recipe> recipes = [];
  Recipes({required this.recipes});

  Recipes filterRecipe({required String contain}) {
    Recipes filterdRecipes = Recipes(recipes: []);
    for (var recipe in recipes) {
      if (recipe.hasIngredient(searchWord: contain)) {
        filterdRecipes.add(recipe: recipe);
      }
    }
    return filterdRecipes;
  }

  void add({required Recipe recipe}) {
    recipes.add(recipe);
  }

  void clear() {
    recipes.clear();
  }
}

class Recipe {
  String id = "";
  String recipe_name = "";
  String explain = "";
  List<material> ingredients = [];
  List<material> spices = [];
  List<String> cookwares = [];
  List<String> cookmethod = [];

  Recipe(
      {required this.id,
      required this.recipe_name,
      required this.explain,
      required this.ingredients,
      required this.spices,
      required this.cookwares,
      required this.cookmethod});

  bool hasIngredient({required String searchWord}) {
    var tmp = this.ingredients.where((element) => element.name == searchWord);
    return !tmp.isEmpty;
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
