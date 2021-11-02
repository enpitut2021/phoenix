///dart~

///package~
import 'package:flutter/material.dart';
import 'package:phoenix/pages/upload_recipe/make_widget.dart';
import 'package:phoenix/recipe/recipe_models.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

///mylibrary~

class UpLoadRecipe extends StatefulWidget {
  const UpLoadRecipe({Key? key}) : super(key: key);

  @override
  _UpLoadRecipeState createState() => _UpLoadRecipeState();
}

class _UpLoadRecipeState extends State<UpLoadRecipe> with MakeWidget {
  @override
  void initState() {
    super.initState();
    state = setState;
    recipe = Recipe(
        id: '',
        recipename: '',
        imageurl: '',
        ingredients: [],
        cookmethod: [],
        cookwares: [],
        explain: [],
        spices: []);
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    //ドキュメントID生成関数
    // String makeDocId(){
    //  return
    // }

    // var makewidget = MakeWidget(
    //     recipe: recipe,
    //     state: () {
    //       setState(() {});
    //     });

    return Scaffold(
      appBar: AppBar(
        title: const Text('レシピ作成画面'),
      ),
      body: setRecipe(
          context: context,
          screenSize: screenSize,
          onTap: () async {
            List<Map<String, String>> tmp1 = [], tmp2 = [];
            for (var _ingredients in recipe.ingredients) {
              tmp1.add({'name': _ingredients.name});
              tmp1.add({'amount': _ingredients.amount});
            }
            for (var _spices in recipe.spices) {
              tmp2.add({'name': _spices.name});
              tmp2.add({'amount': _spices.amount});
            }
            await FirebaseFirestore.instance
                .collection('recipes')
                .doc(/*makeDocId*/)
                .set({
              'id': recipe.id,
              'recipe_name': recipe.recipename,
              'imageurl': recipe.imageurl,
              'ingredients': tmp1,
              'cookmethod': recipe.cookmethod,
              'cookwares': recipe.cookwares,
              'explain': recipe.explain,
              'spices': tmp2,
              // 'minutes': recipe.minutes
            });
          }),
    );
  }
}
