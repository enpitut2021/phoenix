import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phoenix/common_widget/image_operation.dart';
import 'package:phoenix/common_widget/makelist.dart';
import 'package:phoenix/Model/recipe/recipe_models.dart';

class MakeWidget {
  late Recipe recipe;
  late Function state;
  String name = "";
  String amount = "";

  Widget setRecipe(
      {required BuildContext context,
      required Size screenSize,
      required void Function()? onTap,
      required MyImage imagepicker}) {
    Widget setrecipewidget = ListView(
      shrinkWrap: true,
      children: [
        // 画像,
        imagepicker.imageAsset(),
        _labelWithButton('レシピの名前', screenSize.width, () {
          _makedialog(context, "レシピ名", false);
        }),
        Text(recipe.recipename),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            makeChangeableMaterialList(
                materials: recipe.toFoodstuffs(recipe.ingredients),
                screenwidth: screenSize.width / 2.2,
                titlewidget: _labelWithButton('材料', screenSize.width / 2, () {
                  _makedialog(context, "材料", true);
                  },
                ),
              onTap:state,
            ),
            makeChangeableMaterialList(
                materials: recipe.toFoodstuffs(recipe.spices),
                screenwidth: screenSize.width / 2.2,
                titlewidget: _labelWithButton('調味料', screenSize.width / 2, () {
                  _makedialog(context, "調味料", true);
                }
              ),
              onTap: state,
            ),
            
          ],
        ),
        makeChangeableMaterialList(
            materials: recipe.explain,
            screenwidth: screenSize.width,
            titlewidget: _labelWithButton('説明', screenSize.width, () {
              _makedialog(context, "説明", false);
            }),
            onTap: state,
            ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            makeChangeableMaterialList(
                materials: recipe.cookwares,
                screenwidth: screenSize.width / 2.2,
                titlewidget: _labelWithButton('調理器具', screenSize.width / 2, () {
                  _makedialog(context, "調理器具", false);
                }),
                onTap: state,
            ),
            makeChangeableMaterialList(
                materials: recipe.cookmethod,
                screenwidth: screenSize.width / 2.2,
                titlewidget: _labelWithButton('調理方法', screenSize.width / 2, () {
                  _makedialog(context, "調理方法", false);
                }),
                onTap: state,
                ),
          ],
        ),
        ElevatedButton(child: const Text('投稿する'), onPressed: onTap),
      ],
    );

    return setrecipewidget;
  }

  Widget _labelWithButton(String text, double width, Function()? ontap) {
    return SizedBox(
      width: width,
      height: 40,
      child: Stack(
        children: <Widget>[
          Container(
            child: Text(text),
            alignment: Alignment.centerLeft,
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

  void _makedialog(BuildContext context, String field, bool flag) {
    List<Widget> displayAddDaialog = _add(field, flag);
    displayAddDaialog.add(
      Container(
        width: double.infinity,
        child: ElevatedButton(
          child: const Text("追加"),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      )
    );

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
                title: Container(
                    child: const Text("追加する内容！！！"),
                    alignment: Alignment.center),
                actions: displayAddDaialog);
          },
        );
      },
    ).then((context) {
      state(() {
        if (!(name == "" || (flag && amount == ""))) {
          _updaterecipe(field);
        }
        name = "";
        amount = "";
      });
    });
  }

  List<Widget> _add(String field, bool flag) {
    name = '';
    amount = '';
    List<Widget> output = <Widget>[
      Container(child: Text(field), alignment: Alignment.centerLeft),
      TextFormField(
        textInputAction: TextInputAction.done,
        onChanged: (String str) {
          name = str;
        },
      ),
    ];
    if (flag) {
      output.add(
        Container(child: const Text("分量"), alignment: Alignment.centerLeft)
      );
      output.add(
        TextFormField(
          onChanged: (String str) {
            amount = str;
          },
        )
      );
    }
    return output;
  }

  void _updaterecipe(String title) {
    if (title == "レシピ名") {
      recipe.recipename = name;
    } else if (title == "材料") {
      recipe.ingredients.add(Foodstuff(name: name, amount: amount));
    } else if (title == "調味料") {
      recipe.spices.add(Foodstuff(name: name, amount: amount));
    } else if (title == "説明") {
      recipe.explain.add(name);
    } else if (title == "調理器具") {
      recipe.cookwares.add(name);
    } else if (title == "調理方法") {
      recipe.cookmethod.add(name);
    }
  }
}
