///dart~

///package~
import 'package:flutter/material.dart';
import 'package:phoenix/pages/upload_recipe/make_widget.dart';
import 'package:phoenix/recipe/recipe_models.dart';
import 'package:tuple/tuple.dart';

///mylibrary~

class UpLoadRecipe extends StatefulWidget {
  const UpLoadRecipe({Key? key}) : super(key: key);

  @override
  _UpLoadRecipeState createState() => _UpLoadRecipeState();
}

class _UpLoadRecipeState extends State<UpLoadRecipe> {
  Recipe recipe = Recipe(
      id: '',
      recipename: '',
      imageurl: '',
      ingredients: [],
      cookmethod: [],
      cookwares: [],
      explain: [],
      spices: []);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: const Text('レシピ作成画面'),
        ),
        body: setRecipe(
            context: context,
            screenSize: screenSize,
            recipe: recipe,
            onTap: () {}));
  }
}
