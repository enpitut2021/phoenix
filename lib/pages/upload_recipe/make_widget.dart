import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phoenix/common_widget/makelist.dart';
import 'package:phoenix/recipe/recipe_models.dart';

Widget _labelWithButton(String text, double width, Function()? ontap) {
  return SizedBox(
    width: width,
    height: 40,
    child: Stack(
      children: <Widget>[
        Container(
          child: Text(text),
          alignment: Alignment.center,
          color: Colors.orange,
        ),
        Container(
          child: ElevatedButton(
            child: const Icon(Icons.add),
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              shape: const CircleBorder(
                side: BorderSide(
                  color: Colors.black,
                  width: 1,
                  style: BorderStyle.solid,
                ),
              ),
            ),
            onPressed: ontap,
          ),
          alignment: Alignment.bottomRight,
        ),
      ],
    ),
  );
}

Widget setRecipe(
    {required BuildContext context,
    required Size screenSize,
    required Recipe recipe,
    required void Function()? onTap}) {
  return Column(
    children: [
      // 画像,
      _labelWithButton('レシピの名前', screenSize.width, () {
        makedialog(context, "レシピ名", false);
      }),
      Text(recipe.recipename),
      Row(
        children: <Widget>[
          menueDetailMaterial(
              materials: recipe.toFoodstuffs(recipe.ingredients),
              screenwidth: screenSize.width / 2.2,
              titlewidget: _labelWithButton('材料', screenSize.width / 2, () {
                makedialog(context, "材料", true);
              })),
          menueDetailMaterial(
              materials: recipe.toFoodstuffs(recipe.spices),
              screenwidth: screenSize.width / 2.2,
              titlewidget: _labelWithButton('調味料', screenSize.width / 2, () {
                makedialog(context, "調味料", true);
              })),
        ],
      ),
      menueDetailMaterial(
          materials: recipe.explain,
          screenwidth: screenSize.width / 2,
          titlewidget: _labelWithButton('説明', screenSize.width, () {
            makedialog(context, "説明", false);
          })),
      Row(
        children: <Widget>[
          menueDetailMaterial(
              materials: recipe.cookwares,
              screenwidth: screenSize.width / 2.2,
              titlewidget: _labelWithButton('調理器具', screenSize.width / 2, () {
                makedialog(context, "調理器具", false);
              })),
          menueDetailMaterial(
              materials: recipe.cookmethod,
              screenwidth: screenSize.width / 2.2,
              titlewidget: _labelWithButton('調理方法', screenSize.width / 2, () {
                makedialog(context, "調理器具", false);
              })),
        ],
      ),
      ElevatedButton(
        child: const Text('投稿する'),
        onPressed: onTap,
      ),
    ],
  );
}

void makedialog(BuildContext context, String field, bool flag) {
  List<Widget> display_add_daialog = _add(field, flag);
  display_add_daialog.add(Container(
      width: double.infinity,
      child: ElevatedButton(
        child: const Text("追加"),
        onPressed: () {
          Navigator.pop(context);
        },
      )));

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
              title: Container(
                  child: const Text("追加する内容！！！"), alignment: Alignment.center),
              actions: display_add_daialog);
        },
      );
    },
  ).then((context) {});
}

List<Widget> _add(String field, bool flag) {
  List<Widget> output = <Widget>[
    Container(child: Text(field), alignment: Alignment.centerLeft),
    TextFormField(
      onFieldSubmitted: (String str) {},
    ),
  ];
  if (flag) {
    output.add(
        Container(child: const Text("分量"), alignment: Alignment.centerLeft));
    output.add(TextFormField(
      onFieldSubmitted: (String str) {},
    ));
  }
  return output;
}
