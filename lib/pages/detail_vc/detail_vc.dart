///dart~
///package~
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

///my library
import 'Model/recipe/recipe_models.dart';
import 'make_widget.dart';

class DetailOfMenu extends StatefulWidget {
  const DetailOfMenu({Key? key}) : super(key: key);

  @override
  State<DetailOfMenu> createState() => _detailRecipe();
}

// ignore: camel_case_types
class _detailRecipe extends State<DetailOfMenu>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));

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
    final recipe =
        (ModalRoute.of(context)!.settings.arguments as RecipeArgument)
            .recipe; //type is Recipe
    final _dynamicdisplayimage = DynamicDisplayImage(0, _animationController);

    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.recipename),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
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
          setMenue(recipe, screenSize),
          _dynamicdisplayimage.zoomImage(recipe, screenSize)
        ],
      ),
    );
  }
}
