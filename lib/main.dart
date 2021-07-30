import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //タイトル後で変更
      title: 'Flutter Demo',

      //ルート設定
      initialRoute: '/',
      routes: {
        '/': (context) => SuggestMenus(),
        '/detail': (context) => DetailOfMenu(),
      },

      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
    );
  }
}

class SuggestMenus extends StatefulWidget {
  const SuggestMenus({Key? key}) : super(key: key);

  @override
  _SuggestMenusState createState() => _SuggestMenusState();
}

class _SuggestMenusState extends State<SuggestMenus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ランダムにメニューを提案'),
      ),
      body: _buildSuggestions(),
    );
  }

  List _shuffle(List items) {
    var random = new math.Random();
    for (var i = items.length - 1; i > 0; i--) {
      var n = random.nextInt(i + 1);
      var temp = items[i];
      items[i] = items[n];
      items[n] = temp;
    }
    return items;
  }

  Widget _buildSuggestions() {
    //このリストはあとでjsonからとってくるようにする
    final List<RecipeTest> Menus = <RecipeTest>[
      new RecipeTest('カレーライス', 'カレールーと野菜'),
      new RecipeTest('卵焼き', '卵を焼く'),
      new RecipeTest('ハンバーグ', '筆記肉')
    ];
    final randomMenus = _shuffle(Menus);

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: Menus.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          child: _tile(randomMenus[index]),
        );
      },
    );
  }

  //あとで引数の型を変更する
  Widget _tile(RecipeTest menu) {
    return Card(
      color: Colors.orange.shade200,
      child: ListTile(
        title: Text(
          menu.name,
          style: const TextStyle(fontSize: 24),
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            '/detail',
            arguments: RecipeArgument(menu),
          );
        },
      ),
    );
  }
}

class DetailOfMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as RecipeArgument;

    return Scaffold(
      appBar: AppBar(
        title: Text(args.recipe.name),
      ),
      body: Column(
        children: <Widget>[
          //
          //写真
          //
          Card(
            child: Container(
              color: Colors.orange.shade200,
              width: double.infinity,
              child: Text(
                '材料',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
          //この部分を箇条書きに
          Text(args.recipe.explain),

          Card(
            child: Container(
              color: Colors.orange.shade200,
              width: double.infinity,
              child: Text(
                '作り方',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
          //この部分を箇条書き/文章形式に
          Text(args.recipe.explain),
        ],
      ),
    );
  }
}

//ここはjsonから読み込む形式に変更
class RecipeTest {
  String name = "";
  String explain = "";

  RecipeTest(this.name, this.explain);
}

class RecipeArgument {
  RecipeTest recipe;

  RecipeArgument(this.recipe);
}
