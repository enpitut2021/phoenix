class Recipes{
  List<Recipe> recipes = [];
  Recipes({required this.recipes});
}

class Recipe{
  String id = "";
  String recipe_name = "";
  String explain = "";
  List<material> ingredients = [];
  List<material> spices = [];
  List<String> cookwares = [];
  List<String> cookmethod = [];

  Recipe({required this.id,required this.recipe_name,required this.explain,
    required this.ingredients,required this.spices,
    required this.cookwares,required this.cookmethod});
}

class material{//ingredient or spice
  String name = "";
  String amount = "";

  material({required this.name,required this.amount});
}