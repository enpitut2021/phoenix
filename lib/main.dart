///dart~

///package~
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:phoenix/Model/user/user_model.dart';
import 'package:phoenix/pages/profil/friend_list.dart';
import 'package:phoenix/pages/profil/register_list.dart';

///mylibrary~
import 'recipe/load_data.dart';
import 'recipe/recipe_models.dart';
import './pages/detail_vc/detail_vc.dart';
import 'data/operatelist.dart';
import './pages/search_vc/search_vc.dart';
import './pages/upload_recipe/upload_page.dart';
import 'package:phoenix/pages/profil/profil.dart';
import 'package:phoenix/common_widget/friend_list_widget.dart';
import 'package:phoenix/common_widget/register_list_widget.dart';
import 'package:phoenix/Model/user/user_model.dart';

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
        '/uploadrecipe': (context) => const UpLoadRecipe(),
        '/profil': (context) => const ProfilPage(),
        '/friendList': (context) => const FriendList(),
        '/registerPage': (context) => const RegisterList()
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
    loadSectiontask.loadFirestoreAsset().then((value) {
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
      drawer: Drawer(
        child: ListView(children: <Widget>[
          const DrawerHeader(
            child: Text(
              'メニュー',
            ),
          ),
          ListTile(
            title: const Text('レシピ投稿'),
            onTap: () {
              Navigator.pushNamed((context), '/uploadrecipe');
            },
          ),
          ListTile(
            title: const Text('プロフィール'),
            onTap: () {
              Navigator.pushNamed((context), '/profil');
            },
          ),
          // ListTile(
          //   title: const Text('フレンドリスト'),
          //   onTap: () {
          //     Navigator.pushNamed((context), '/friendList');
          //   },
          // ),
          // ListTile(
          //   title: const Text('作ったレシピ集'),
          //   onTap: () {
          //     Navigator.pushNamed((context), '/registerPage');
          //   },
          // ),
        ]),
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
            //Image.asset(recipe.imageurl),
            Image.network(recipe.imageurl),
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
