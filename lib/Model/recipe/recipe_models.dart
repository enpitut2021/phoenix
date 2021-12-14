import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

import '/data/operatelist.dart' show toHira;
import 'package:cloud_firestore/cloud_firestore.dart';

class Recipes {
  List<Recipe> recipes = [];
  Recipes({required recipes});

  Recipes filterrecipe(
      {required List<String> contains, required int time_bound}) {
    Recipes filteredrecipes = Recipes(recipes: []);
    List<String> ids = [];

    //検索ワードがない時
    if (contains.isEmpty) {
      var tmp = recipes.where((recipe) => (recipe.time <= time_bound));
      for (var obj in tmp) {
        filteredrecipes.add(recipe: obj);
        ids.add(obj.id);
      }
      return filteredrecipes;
    } else {
      for (var contein in contains) {
        var tmp = recipes.where((recipe) =>
            ((recipe.hasIngredient(searchword: contein) ||
                    (recipe.hasSpice(searchword: contein))) &&
                recipe.aleadyExist(ids) &&
                (recipe.time <= time_bound)));
        for (var obj in tmp) {
          filteredrecipes.add(recipe: obj);
          ids.add(obj.id);
        }
      }
      return filteredrecipes;
    }
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
  int time = 0;
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
      required this.cookmethod,
      required this.time});

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

  Future<DocumentReference<Map<String, dynamic>>> uploadRecipe() async {
    List<Map<String, String>> tmp1 = [], tmp2 = [];
    var i = 0;
    for (var _ingredients in ingredients) {
      tmp1.add({'ingredient': 'quantity'});
      tmp1[i]['ingredient'] = _ingredients.name;
      tmp1[i]['quantity'] = _ingredients.amount;
      i++;
    }
    var j = 0;
    for (var _spices in spices) {
      tmp2.add({'spice': 'amount'});
      tmp2[j]['spice'] = _spices.name;
      tmp2[j]['amount'] = _spices.amount;
      j++;
    }

    final refiid = await FirebaseFirestore.instance.collection('recipes').add({
      'id': '0',
      'recipe_name': recipename,
      'ingredients': tmp1,
      'method': cookmethod,
      'cookwares': cookwares,
      'explain': explain,
      'spices': tmp2,
      'time': time,
    });

    // // 画像をfirestorageにぶち込む
    // await imagePicker.upload(refiid.id).then((value) => {
    //       recipe.imageurl = value,
    //     });
    // await FirebaseFirestore.instance
    //     .collection('recipes')
    //     .doc(refiid.id)
    //     .update({'imageurl': imageurl});
    return Future<DocumentReference<Map<String, dynamic>>>.value(refiid);
  }

  int _flag = 0;

  Future<String> upload(String filename, File? image) async {
    late Future<String> imagePath;
    if (_flag == 0) {
      imageurl = filename + ".jpeg";
      _flag += 1;
    }
    // imagePickerで画像を選択する
    // upload
    FirebaseStorage storage = FirebaseStorage.instance;
    try {
      await storage.ref(imageurl).putFile(image!);
      imagePath = storage.ref(imageurl).getDownloadURL();
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    return Future<String>.value(imagePath);
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
