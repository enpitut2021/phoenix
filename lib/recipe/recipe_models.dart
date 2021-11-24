import '../data/operatelist.dart' show toHira;
import 'package:cloud_firestore/cloud_firestore.dart';

class Recipes {
  List<Recipe> recipes = [];
  Recipes({required recipes});

  Recipes filterrecipe({required List<String> contains}) {
    Recipes filteredrecipes = Recipes(recipes: []);
    List<String> ids = [];

    //検索ワードがない時
    if (contains.isEmpty) {
      return this;
    }

    for (var contein in contains) {
      var tmp = recipes.where((recipe) =>
          ((recipe.hasIngredient(searchword: contein) ||
                  (recipe.hasSpice(searchword: contein))) &&
              recipe.aleadyExist(ids)));
      for (var obj in tmp) {
        filteredrecipes.add(recipe: obj);
        ids.add(obj.id);
      }
    }
    return filteredrecipes;
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
  String imageurl = "";
  String recipename = "";
  List<String> explain = [];
  List<Foodstuff> ingredients = [];
  List<Foodstuff> spices = [];
  List<String> cookwares = [];
  List<String> cookmethod = [];

  Recipe(
      {required this.id,
      required this.imageurl,
      required this.recipename,
      required this.explain,
      required this.ingredients,
      required this.spices,
      required this.cookwares,
      required this.cookmethod});

  bool hasIngredient({required String searchword}) {
    var tmp = ingredients
        .where((element) => toHira(element.name).contains(searchword));
    return tmp.isNotEmpty;
  }

  bool hasSpice({required String searchword}) {
    var tmp =
        spices.where((element) => toHira(element.name).contains(searchword));
    return tmp.isNotEmpty;
  }

  bool aleadyExist(List<String> ids) {
    final tmp = ids.where((id) => this.id == id);
    return tmp.isEmpty;
  }

  ///具材の名前　量　のリストを表示を表示　引数は具材または調味料のリスト
  List<String> toFoodstuffs(List<Foodstuff> foodstuffs) {
    List<String> foodsufslist = [];
    for (var fd in foodstuffs) {
      foodsufslist.add(fd.name + " " + fd.amount);
    }
    return foodsufslist;
  }

  Future<int> createDocumentID(int userid) async {
    int tmp = userid + 10000; //userid:4 + recipeid:4
    try {
      await FirebaseFirestore.instance
          .collection('recipe')
          .orderBy('id', descending: true)
          .limit(1)
          .get()
          .then((value) => {
                tmp += (value.docs[0].get('id') + 1) as int,
                id = tmp.toString(),
              });
      return Future<int>.value(tmp);
    } catch (e) {
      return Future<int>.value(0);
    }
  }
}

class Foodstuff {
  //ingredient or spice
  String name = "";
  String amount = "";

  Foodstuff({required this.name, required this.amount});
}

class RecipeArgument {
  Recipe recipe;
  RecipeArgument(this.recipe);
}
