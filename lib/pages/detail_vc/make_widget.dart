import 'package:flutter/material.dart';
import '../../recipe/recipe_models.dart';
import '../../common_widget/makelist.dart';

Widget _recipeField({required double screenwidth, required String title}) {
  return (Card(
    child: Container(
      color: Colors.orange.shade200,
      width: screenwidth,
      child: Text(
        title,
        style: const TextStyle(fontSize: 24),
      ),
    ),
  ));
}

Widget setMenue(Recipe recipe, Size screenSize) {
  return Flexible(
    child: ListView(
      shrinkWrap: true,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            menueDetailMaterial(
                materials: recipe.toFoodstuffs(recipe.ingredients),
                screenwidth: screenSize.width / 2.2,
                titlewidget: _recipeField(
                    screenwidth: screenSize.width / 2.2, title: '材料')),
            menueDetailMaterial(
                materials: recipe.toFoodstuffs(recipe.spices),
                screenwidth: screenSize.width / 2.2,
                titlewidget: _recipeField(
                    screenwidth: screenSize.width / 2.2, title: '調味料')),
          ],
        ),
        menueDetailMaterial(
            materials: recipe.explain,
            screenwidth: screenSize.width,
            titlewidget:
                _recipeField(screenwidth: screenSize.width, title: '作り方')),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            menueDetailMaterial(
                materials: recipe.cookwares,
                screenwidth: screenSize.width / 2.2,
                titlewidget: _recipeField(
                    screenwidth: screenSize.width / 2.2, title: '調理器具')),
            menueDetailMaterial(
                materials: recipe.cookmethod,
                screenwidth: screenSize.width / 2.2,
                titlewidget: _recipeField(
                    screenwidth: screenSize.width / 2.2, title: '調理方法')),
          ],
        ),
      ],
    ),
  );
}

class DynamicDisplayImage {
  int animationindex = 0;
  late AnimationController _animationController;

  DynamicDisplayImage(
      int animationindex, AnimationController _animationController) {
    // ignore: prefer_initializing_formals
    this.animationindex = animationindex;
    this._animationController = _animationController;
  }

  // ignore: non_constant_identifier_names
  Widget rotateImage(Recipe recipe, Size screenSize) {
    return Center(
      child: RotationTransition(
        alignment: Alignment.center + const Alignment(0, 0.3),
        turns: _animationController
            .drive(
              CurveTween(
                curve: Curves.elasticOut,
              ),
            )
            .drive(
              Tween<double>(
                begin: 0,
                end: 1,
              ),
            ),
        // child: Image.asset(recipe.imageurl),
        child: Image.asset(recipe.imageurl),
      ),
    );
  }

  Widget zoomImage(Recipe recipe, Size screenSize) {
    return Center(
      child: ScaleTransition(
        alignment: Alignment.center + const Alignment(0, 0.3),
        scale: _animationController
            .drive(
              CurveTween(
                curve: Curves.elasticOut,
              ),
            )
            .drive(
              Tween<double>(
                begin: 0.3,
                end: 1,
              ),
            ),
        //child: Image.asset(recipe.imageurl),
        child: Image.network(recipe.imageurl),
      ),
    );
  }
}
