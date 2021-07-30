import 'package:flutter/material.dart';
import 'dart:math' as math;
import './data/LoadData.dart';
import './data/Recipes.dart';

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
        '/': (context) => SuggestRecipes(),
        '/detail': (context) => DetailOfMenu(),
      },

      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
    );
  }
}

class SuggestRecipes extends StatefulWidget {
  const SuggestRecipes({Key? key}) : super(key: key);

  @override
  _SuggestRecipesState createState() => _SuggestRecipesState();
}

class _SuggestRecipesState extends State<SuggestRecipes> {
  List<Recipe> recipes = [];
  LoadRecipes loadSectiontask = LoadRecipes();

  @override
  void initState() {
    super.initState();
    loadSectiontask.loadJsonAsset().then((value) {
      setState(() {
        recipes = value;
        assert(recipes.isNotEmpty);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ランダムにメニューを提案'),
      ),
      body: _buildSuggestions(recipes),
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

  Widget _buildSuggestions(List<Recipe> recipes) {
    //このリストはあとでjsonからとってくるようにする
    // final List<RecipeTest> Menus = <RecipeTest>[
    //   new RecipeTest('カレーライス', 'カレールーと野菜'),
    //   new RecipeTest('卵焼き', '卵を焼く'),
    //   new RecipeTest('ハンバーグ', '筆記肉')
    // ];

    final randomRecipes = _shuffle(recipes);

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: recipes.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          child: _tile(randomRecipes[index]),
        );
      },
    );
  }

  //あとで引数の型を変更する
  Widget _tile(Recipe recipe) {
    return Card(
      color: Colors.orange.shade200,
      child: ListTile(
        title: Text(
          recipe.recipe_name,
          style: const TextStyle(fontSize: 24),
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            '/detail',
            arguments: RecipeArgument(recipe),
          );
        },
      ),
    );
  }
}

class DetailOfMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final args = ModalRoute.of(context)!.settings.arguments as RecipeArgument;//type is Recipe

    return Scaffold(
      appBar: AppBar(
        title: Text(args.recipe.recipe_name),
      ),
      body: ListView(
        children: <Widget>[
          //
          //写真
          //
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
             children: <Widget>[
               Column(
                children: <Widget>[
                  Card(
                    child: Container(
                      color: Colors.orange.shade200,
                      width: screenSize.width/2.2,
                      child: Text('材料', style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                  Column(children: displayMaterial(args.recipe.ingredients, screenSize.width/2.2),),
                ],
              ),
               Column(
                  children: <Widget>[
                  Card(
                    child: Container(
                      color: Colors.orange.shade200,
                      width: screenSize.width/2.2,
                      child: Text('調味料', style: TextStyle(fontSize: 24),),
                    ),
                  ),
                  Column(children: displayMaterial(args.recipe.spices, screenSize.width/2.2),),
                  ],
               ),
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
        ],
      ),
    );
  }
}

// //ここはjsonから読み込む形式に変更
// class RecipeTest {
//   String name = "";
//   String explain = "";
//
//   RecipeTest(this.name, this.explain);
// }

List<Widget> displayMaterial(List<material> foodstuffs, double width){
  List<Widget> temp = [];
  for(var foodstuff in foodstuffs){
    temp.add(_tileFoodstuff(foodstuff, width));
  }
  return temp;
}

Widget _tileFoodstuff(material foodstuff, double width){
  return Container(
    child:Text(
      foodstuff.name + " " + foodstuff.amount,
      style: const TextStyle(fontSize: 15),
    ),
    width: width,
    margin: EdgeInsets.all(2),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.white10, width: 1),
    ),
  );
}
