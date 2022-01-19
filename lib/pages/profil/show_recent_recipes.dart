import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phoenix/Model/recipe/recipe_models.dart';
import 'package:phoenix/common_widget/alert_action.dart';
import 'package:phoenix/common_widget/check_login.dart';

class RecentRecipes extends StatefulWidget {
  Recipes recipes;
  final Function delete;
  RecentRecipes({Key? key, required this.recipes, required this.delete})
      : super(key: key);

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
                Image.network(
                  recipe.imageurl,
                  fit: BoxFit.fitHeight,
                  width: width / 4,
                  height: width / 4,
                ),
              ],
            ),
            SingleChildScrollView(
              child: Container(
                child: Text(
                  recipe.recipename,
                  style: const TextStyle(fontSize: 10),
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
        onLongPress: () {
          setState(() {
            checkLoginStatus().then((status) {
              if (status) {
                ErrorAction.woringMessage(context, "このレシピをお気に入りから削除ますがよろしいですか？")
                    .then((yes) {
                  if (yes) {
                    widget.delete(recipeID: recipe.id);
                  }
                });
              } else {
                ErrorAction.errorMessage(context, "ログインが確認できませんでした。");
              }
            });
          });
        },
      ),
    );
  }
}
