///dart~

///package~
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

///mylibrary~
import 'recipe/load_data.dart';
import 'recipe/recipe_models.dart';
import './pages/detail_vc/detail_vc.dart';
import 'data/operatelist.dart';
import './pages/search_vc/search_vc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        '/': (context) => const SuggestRecipes(),
        '/detail': (context) => const DetailOfMenu(),
        '/search': (context) => const SearchVC(),
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
  // ignore: non_constant_identifier_names
  Recipes search_debug = Recipes(recipes: []);
  List<String> searchWords = [];

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
    FirebaseFirestore.instance
        .collection('recipes')
        .doc('01000001')
        .get()
        .then((ref){
          print(ref.get('recipe_name'));
        }).catchError((error) => {
          print(error)
        });
    return Scaffold(
      appBar: AppBar(
        title: const Text('ランダムにメニューを提案'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => {
              Navigator.pushNamed(context, '/search').then((value) => {
                    setState(() {
                      searchWords = (value as SendData).words;
                    }),
                  }),
            },
          ),
        ],
      ),
      body: _buildSuggestions(
          recipes.filterrecipe(contains: searchWords).recipes),
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
        title: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Image.asset(recipe.imageurl),
            Container(
              child: Text(
                recipe.recipename,
                style: const TextStyle(fontSize: 24),
              ),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
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
