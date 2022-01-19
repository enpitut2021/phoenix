import 'package:flutter/material.dart';
import 'package:phoenix/Model/recipe/recipe_models.dart';

class RegisterList extends StatefulWidget {
  // Recipes uploadRecipes;
  const RegisterList({Key? key}) : super(key: key);

  @override
  _SuggestRegisterListState createState() => _SuggestRegisterListState();
}

class _SuggestRegisterListState extends State<RegisterList> {
  @override
  Widget build(BuildContext context) {
    Recipes recipes = (ModalRoute.of(context)!.settings.arguments as Recipes);
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('投稿したレシピリスト'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: recipes.recipes.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: _tile(recipes.get(at: index), width),
          );
        },
      ),
    );
  }

  Widget _tile(Recipe recipe, double width) {
    return Card(
      color: Colors.orange.shade200,
      child: ListTile(
        title: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Stack(
              alignment: Alignment.topLeft,
              children: [
                Container(
                  child: Image.network(
                    recipe.imageurl,
                    width: width,
                    height: width / 2,
                    fit: BoxFit.cover,
                  ),
                  // width: width,
                  // height: width / 2,
                ),
              ],
            ),
            SingleChildScrollView(
              child: Container(
                child: Text(
                  recipe.recipename,
                  style: const TextStyle(fontSize: 24),
                ),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            '/detail',
            arguments: RecipeArgument(recipe),
          );
        },
      ),
    );
  }
}
