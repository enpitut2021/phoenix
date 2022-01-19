import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phoenix/Model/recipe/recipe_models.dart';
import 'package:phoenix/Model/recipe/load_data.dart';
import 'package:phoenix/common_widget/check_login.dart';
import 'package:phoenix/pages/profil/profill_option_bar.dart';
import 'package:phoenix/pages/profil/show_recent_recipes.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  final user = FirebaseAuth.instance.currentUser;
  String userName = "未設定";
  Recipes uploadRecipes = Recipes();
  Recipes recentRecipes = Recipes();
  int cookCount = 0;
  @override
  void initState() {
    super.initState();
    _fetch();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('プロフィール'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => {
              Navigator.pushNamed((context), '/login').then((value) {
                setState(() {
                  userName = value.toString();
                });
              })
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: Text(
              userName,
              style: const TextStyle(fontSize: 20),
            ),
            alignment: Alignment.center,
            color: Colors.orange,
          ),
          ProfillOption(cookCount: cookCount, uploadRecipes: uploadRecipes),
          Container(
            child: const Text(
              "お気に入りにしたレシピ達！！！",
              style: TextStyle(fontSize: 20),
            ),
            alignment: Alignment.center,
            color: Colors.orange,
          ),
          RecentRecipes(recipes: recentRecipes, delete: _deleteRecentRecipe),
        ],
      ),
    );
  }

  Future<void> _fetch() async {
    await checkLoginStatus().then((status) async {
      if (status) {
        userName = user!.displayName!;
        final _usersInfo =
            FirebaseFirestore.instance.collection('Users').doc(user!.uid);
        List<dynamic> _recipesId = [];
        List<dynamic> _recentRecipesId = [];

        await _usersInfo.get().then((data) {
          cookCount = data['cook_count'] as int;
          _recipesId = data['you_upload_recipes_id'].cast<String>();
          _recentRecipesId = data['favorit_recipes_id'].cast<String>();
        });

        for (String recipeId in _recipesId) {
          await LoadRecipes.loadFirestoreAssetAt(recipeId).then((recipe) {
            uploadRecipes.add(recipe: recipe);
          });
        }

        for (String recipeId in _recentRecipesId) {
          await LoadRecipes.loadFirestoreAssetAt(recipeId).then((recipe) {
            recentRecipes.add(recipe: recipe);
          });
        }
      }
      setState(() {
        print("Hello world");
      });
    });
    return Future<void>.value();
  }

  void _deleteRecentRecipe({required String recipeID}) {
    setState(() {
      final user = FirebaseAuth.instance.currentUser;
      final userInfo =
          FirebaseFirestore.instance.collection('Users').doc(user!.uid);

      recentRecipes.remove(id: recipeID);
      userInfo.update({
        'favorit_recipes_id': recentRecipes.getRecipeIDs(),
      });
    });
  }
}
