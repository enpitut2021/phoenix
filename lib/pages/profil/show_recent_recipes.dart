import 'package:flutter/material.dart';
import 'package:phoenix/Model/recipe/recipe_models.dart';

class RecentRecipes extends StatefulWidget {
  Recipes recipes;
  RecentRecipes({Key? key, required this.recipes}) : super(key: key);

  @override
  _RecentRecipesState createState() => _RecentRecipesState();
}

class _RecentRecipesState extends State<RecentRecipes> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GridView.count(
      crossAxisCount: 3,
      children: _createRecentRecipesList(),
    ));
  }

  List<Widget> _createRecentRecipesList() {
    List<Widget> _recentRecipes = [];
    for (Recipe recipe in widget.recipes.recipes) {
      _recentRecipes.add(_tile(recipe));
    }
    return _recentRecipes;
  }

  Widget _tile(Recipe recipe) {
    final width = MediaQuery.of(context).size.width;
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
                    fit: BoxFit.cover,
                  ),
                  width: width / 3,
                  height: width / 3,
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
