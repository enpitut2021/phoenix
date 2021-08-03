import 'package:flutter/material.dart';
import '../recipe/Recipes.dart';
import './makeWidget.dart';
import 'package:flutter/animation.dart';

class DetailOfMenu extends StatefulWidget {
  const DetailOfMenu({Key? key}) : super(key: key);

  @override
  State<DetailOfMenu> createState() => _detailRecipe();
}

class _detailRecipe extends State<DetailOfMenu>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 3000));

    _animationController.forward(from: 0);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final args = ModalRoute.of(context)!.settings.arguments
        as RecipeArgument; //type is Recipe

    return Scaffold(
      appBar: AppBar(
        title: Text(args.recipe.recipe_name),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _animationController.forward(from: 0);
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        verticalDirection: VerticalDirection.up,
        children: <Widget>[
          Flexible(
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    menuDetailMaterial(
                        title: '材料',
                        materials: args.recipe.ingredients,
                        screenwidth: screenSize.width / 2.2),
                    menuDetailMaterial(
                        title: '調味料',
                        materials: args.recipe.spices,
                        screenwidth: screenSize.width / 2.2),
                  ],
                ),
                Card(
                  child: Container(
                    color: Colors.orange.shade200,
                    width: screenSize.width,
                    child: Text(
                      '作り方',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ),
                //この部分を箇条書き/文章形式に
                Text(args.recipe.explain),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    menuDetailObjects(
                        title: '調理器具',
                        objects: args.recipe.cookwares,
                        screenwidth: screenSize.width / 2.2),
                    menuDetailObjects(
                        title: '調理方法',
                        objects: args.recipe.cookmethod,
                        screenwidth: screenSize.width / 2.2),
                  ],
                ),
              ],
            ),
          ),
          Center(
            child: RotationTransition(
              alignment: Alignment.center + Alignment(0, 0.3),
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
              child: Image.asset(args.recipe.imageUrl),
            ),
          ),
        ],
      ),
    );
  }
}
