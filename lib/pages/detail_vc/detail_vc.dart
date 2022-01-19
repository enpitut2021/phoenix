import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phoenix/Model/recipe/recipe_models.dart';
import 'package:phoenix/common_widget/alert_action.dart';
import 'package:phoenix/common_widget/animation_image.dart';
import 'package:phoenix/common_widget/check_login.dart';
import 'package:phoenix/pages/detail_vc/make_widget.dart';

class DetailVC extends StatefulWidget {
  const DetailVC({Key? key}) : super(key: key);

  @override
  _DetailVCState createState() => _DetailVCState();
}

class _DetailVCState extends State<DetailVC> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final recipe =
        (ModalRoute.of(context)!.settings.arguments as RecipeArgument)
            .recipe; //type is Recipe

    return Scaffold(

        appBar: AppBar(
          title: Text(recipe.recipename),
          actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => {
              Navigator.pushNamed(
                context,
                '/edit',
                arguments: RecipeArgument(recipe),
              )
            },
          ),
        ],
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            verticalDirection: VerticalDirection.up,
            children: <Widget>[
              _cookCountButton(screenSize.width),
              setMenue(recipe, screenSize),
              Stack(children: <Widget>[
                DisplayDynmaicImage(),
                favoriteButton(),
              ]),
            ]));
  }

  Widget favoriteButton() {
    final recipe =
        (ModalRoute.of(context)!.settings.arguments as RecipeArgument).recipe;

    Widget favoriteButton = Container(
      child: ElevatedButton(
        child: const Icon(
          Icons.favorite,
          color: Colors.orange,
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.orange.shade100,
          shape: const CircleBorder(
            side: BorderSide(
              color: Colors.orange,
              width: 1,
              style: BorderStyle.solid,
            ),
          ),
        ),
        onPressed: () {
          checkLoginStatus().then((status) async {
            if (!status) {
              await Navigator.pushNamed((context), '/login');
            }
            await ErrorAction.woringMessage(context, "このレシピをお気に入りに登録します。")
                .then((yes) async {
              if (yes) {
                try {
                  final user = FirebaseAuth.instance.currentUser;
                  final userInfo = FirebaseFirestore.instance
                      .collection('Users')
                      .doc(user!.uid);
                  await userInfo.get().then((data) {
                    List<String> _favoriteRecipe = [];
                    _favoriteRecipe = data['favorit_recipes_id'].cast<String>();
                    if (!_favoriteRecipe.contains(recipe.id)) {
                      _favoriteRecipe.add(recipe.id);
                      userInfo.update({
                        'favorit_recipes_id': _favoriteRecipe,
                      });
                    } else {
                      ErrorAction.errorMessage(context, "すでに登録されています。");
                    }
                  });
                } catch (e) {
                  ErrorAction.errorMessage(context, "登録できませんでした。");
                }
              }
            });
          });
        },

      ),
      alignment: Alignment.bottomRight,
    );

    return favoriteButton;
  }

  Widget _cookCountButton(double width) {
    return Container(
      child: ElevatedButton(
        child: const Text('作ったよ！！'),
        onPressed: () async {
          await checkLoginStatus().then((status) async {
            if (!status) {
              await Navigator.pushNamed((context), '/login');
            }
          });

          try {
            final user = FirebaseAuth.instance.currentUser;
            final userInfo =
                FirebaseFirestore.instance.collection('Users').doc(user!.uid);
            final test = await userInfo.get().then((data) {
              int cookCount = (data['cook_count'] as int) + 1;
              print(cookCount);
              userInfo.update({
                'cook_count': cookCount,
              });
            });

            ErrorAction.errorMessage(context, "作ってくれてありがとう!!");
          } catch (e) {
            ErrorAction.errorMessage(context, "ログインに失敗しました。");
          }
        },
      ),
      width: width,
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
