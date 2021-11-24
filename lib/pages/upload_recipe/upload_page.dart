///dart~

///package~
import 'package:flutter/material.dart';
import 'package:phoenix/common_widget/image_operation.dart';
import 'package:phoenix/pages/upload_recipe/make_widget.dart';
import 'package:phoenix/recipe/recipe_models.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

///mylibrary~

class UpLoadRecipe extends StatefulWidget {
  const UpLoadRecipe({Key? key}) : super(key: key);

  @override
  _UpLoadRecipeState createState() => _UpLoadRecipeState();
}

class _UpLoadRecipeState extends State<UpLoadRecipe> with MakeWidget {
  MyImage imagePicker = MyImage();

  @override
  void initState() {
    super.initState();
    state = setState;
    imagePicker.setstate = setState;
    recipe = Recipe(
        id: '',
        recipename: '',
        imageurl: '',
        ingredients: [],
        cookmethod: [],
        cookwares: [],
        explain: [],
        spices: []);
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    //ドキュメントID生成関数
    String makeDocId() {
      return "aaa";
    }

    String docId = makeDocId();

    // var makewidget = MakeWidget(
    //     recipe: recipe,
    //     state: () {
    //       setState(() {});
    //     });

    return Scaffold(
      appBar: AppBar(
        title: const Text('レシピ作成画面'),
      ),
      body: setRecipe(
          context: context,
          screenSize: screenSize,
          onTap: () async {
            List<Map<String, String>> tmp1 = [], tmp2 = [];
            var i = 0;
            for (var _ingredients in recipe.ingredients) {
              tmp1.add({'ingredient': 'quantity'});
              tmp1[i]['ingredient'] = _ingredients.name;
              tmp1[i]['quantity'] = _ingredients.amount;
              i++;
            }
            var j = 0;
            for (var _spices in recipe.spices) {
              tmp2.add({'spice': 'amount'});
              tmp2[j]['spice'] = _spices.name;
              tmp2[j]['amount'] = _spices.amount;
              j++;
            }
            //画像をfirestorageにぶち込む
            imagePicker.upload(docId);
            await imagePicker.image_path.then((value) => {
                  recipe.imageurl = value,
                });
            await FirebaseFirestore.instance
                .collection('recipes')
                .doc(docId)
                .set({
              'id': recipe.id,
              'recipe_name': recipe.recipename,
              'imageurl': recipe.imageurl,
              'ingredients': tmp1,
              'method': recipe.cookmethod,
              'cookwares': recipe.cookwares,
              'explain': recipe.explain,
              'spices': tmp2,
              // 'minutes': recipe.minutes
            });

            Navigator.pop(context);
          },
          imagepicker: imagePicker),
    );
  }
}
