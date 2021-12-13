import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:phoenix/Model/recipe/recipe_models.dart';

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
    var _width = screenSize.width;
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
        // child: Image.network(
        //   recipe.imageurl,
        //   width: _width,
        //   height: _width / 2,
        //   fit: BoxFit.cover,
        // ),
        child: Container(
          child: Image.network(recipe.imageurl,
              width: _width, height: _width / 3 * 2, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
