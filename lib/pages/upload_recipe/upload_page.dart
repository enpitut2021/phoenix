///dart~

///package~
import 'package:flutter/material.dart';

///mylibrary~

class UpLoadRecipe extends StatefulWidget {
  const UpLoadRecipe({Key? key}) : super(key: key);

  @override
  _UpLoadRecipeState createState() => _UpLoadRecipeState();
}

class _UpLoadRecipeState extends State<UpLoadRecipe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('投稿画面'),
      ),
      body: Column(
        children: [
          // 画像,
          _labelWithButton('タイトル'),
          Row(
            children: <Widget>[
              _labelWithButton('材料'),
              _labelWithButton('調味料'),
            ],
          ),
          _labelWithButton('説明'),
          Row(
            children: <Widget>[
              _labelWithButton('調理器具'),
              _labelWithButton('調理方法'),
            ],
          ),
        ],
      ),
    );
  }
}

Widget _labelWithButton(String text) {
  return Container(
    child: Stack(
      children: <Widget>[
        Container(
          child: Text(text),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: ElevatedButton(
            child: const Icon(Icons.add),
            onPressed: () {},
          ),
          alignment: Alignment.centerLeft,
        ),
      ],
    ),
    alignment: Alignment.center,
    color: Colors.orange,
  );
}
