import 'dart:math';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:phoenix/pages/upload_recipe/upload_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

///mylibrary~
import 'pages/detail_vc/detail_vc.dart';
import 'pages/search_vc/search_vc.dart';
import 'pages/profil/friend_list.dart';
import 'pages/profil/register_list.dart';
import 'pages/profil/profil.dart';
import 'Model/recipe/recipe_models.dart';
import 'Model/recipe/load_data.dart';
import 'Model/user/user_model.dart';
import 'data/operatelist.dart';
import 'common_widget/time_represent.dart';

class UserState extends ChangeNotifier {
  UserModel? user;

  void setUser(UserModel newUser) {
    user = newUser;
    notifyListeners();
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final UserState userstate = UserState();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const locale = Locale("ja", "JP");
    return ChangeNotifierProvider<UserState>(
        create: (context) => userstate,
        child: MaterialApp(
          //タイトル後で変更
          title: 'Flutter Demo',

          //ルート設定
          initialRoute: '/',
          routes: {
            '/': (context) => const SuggestRecipes(),
            '/detail': (context) => DetailVC(),
            '/search': (context) => const SearchVC(),
            '/uploadrecipe': (context) => NewUploadVC(),
            '/profil': (context) => const ProfilPage(),
            '/friendList': (context) => const FriendList(),
            '/registerPage': (context) => const RegisterList()
          },

          theme: ThemeData(
            primarySwatch: Colors.orange,
          ),

          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],

          supportedLocales: const [
            locale,
          ],
        ));
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
  int time_bound = 60;
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(() async {
      final maxScrollExtent = _scrollController.position.maxScrollExtent;
      final minScrollExtent = _scrollController.position.minScrollExtent;
      final currentPosition = _scrollController.position.pixels;
      if (maxScrollExtent > 0 && (maxScrollExtent - 20.0) <= currentPosition) {
        // これから作る予定
        // さらに表示
      } else if (minScrollExtent >= 0 && (minScrollExtent) >= currentPosition) {
        await loadSectiontask.loadFirestoreAsset().then((value) {
          setState(() {
            recipes = value;
            assert(recipes.recipes.isNotEmpty);
          });
        });
      }
    });

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
    //To Access user Model
    //final test = Provider.of<UserState>(context);
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('ランダムにメニューを提案'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => {
              Navigator.pushNamed(context, '/search').then((value) => {
                    setState(() {
                      searchWords = (value as SendDataWithTime).words;
                      time_bound = value.time;
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
          recipes
              .filterrecipe(contains: searchWords, time_bound: time_bound)
              .recipes,
          screenSize),
    );
  }

  Widget _buildSuggestions(List<Recipe> recipes, Size screenSize) {
    final randomRecipes = shuffle(recipes);

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(16),
      itemCount: recipes.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          child: _tile(randomRecipes[index], screenSize.width),
        );
      },
    );
  }

  //あとで引数の型を変更する
  Widget _tile(Recipe recipe, double width) {
    return Card(
      color: Colors.orange.shade200,
      child: ListTile(
        title: Stack(
          alignment: Alignment.bottomRight,
          children: [
            //Image.asset(recipe.imageurl),
            // ignore: avoid_unnecessary_containers
            Stack(
              alignment: Alignment.topLeft,
              children: [
                Container(
                  child: Image.network(
                    recipe.imageurl,
                    width: width,
                    height: width / 2,
                    fit: BoxFit.cover,
                  ),
                  // width: width,
                  // height: width / 2,
                ),
                time_widget(recipe.time),
              ],
            ),

            SingleChildScrollView(
              child: Container(
                child: Text(
                  recipe.recipename,
                  style: const TextStyle(fontSize: 24),
                ),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(10),
                ),
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
