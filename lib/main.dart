import 'package:flutter/material.dart';
import './recipe/LoadData.dart';
import './recipe/Recipes.dart';
import 'detail/detailVC.dart';
import './data/toolsForList.dart';
import './searchVC/searchVC.dart';

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
        '/search': (context) => SearchVC(),
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
  // List<Recipe> recipes = [];
  Recipes recipes = Recipes(recipes: []);
  LoadRecipes loadSectiontask = LoadRecipes();
  Recipes search_debug = Recipes(recipes: []);
  List<String> searchWords = ["水"];

  @override
  void initState() {
    super.initState();
    loadSectiontask.loadJsonAsset().then((value) {
      setState(() {
        recipes = value;
        assert(recipes.recipes.isNotEmpty);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ランダムにメニューを提案'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => {
              Navigator.pushNamed(context, '/search').then((value) => {
                    setState(() {
                      this.searchWords = (value as SendData).words;
                      print(this.searchWords.length);
                    }),
                  }),
            },
          ),
        ],
      ),
      body: _buildSuggestions(
          recipes.filterRecipe(contains: searchWords).recipes),
    );
  }

  Widget _buildSuggestions(List<Recipe> recipes) {
    final randomRecipes = shuffle(recipes);

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
