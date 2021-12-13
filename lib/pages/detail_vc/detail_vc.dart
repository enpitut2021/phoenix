import 'package:flutter/material.dart';
import 'package:phoenix/Model/recipe/recipe_models.dart';
import 'package:phoenix/common_widget/animation_image.dart';
import 'package:phoenix/pages/detail_vc/make_widget.dart';

class DetailVC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final recipe =
        (ModalRoute.of(context)!.settings.arguments as RecipeArgument)
            .recipe; //type is Recipe

    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.recipename),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        verticalDirection: VerticalDirection.up,
        children: <Widget>[
          setMenue(recipe, screenSize),
          DisplayDynmaicImage(),
        ],
      ),
    );
  }
}

class DisplayDynmaicImage extends StatefulWidget {
  @override
  _DisplayDynamicImageState createState() => _DisplayDynamicImageState();
}

class _DisplayDynamicImageState extends State<DisplayDynmaicImage>
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
        (ModalRoute.of(context)!.settings.arguments as RecipeArgument).recipe;
    final _dynamicDisplayImage = DynamicDisplayImage(0, _animationController);
    return _dynamicDisplayImage.zoomImage(recipe, screenSize);
  }
}
