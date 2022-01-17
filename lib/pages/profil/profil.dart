import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phoenix/Model/recipe/recipe_models.dart';
import 'package:phoenix/Model/recipe/load_data.dart';
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
    if (user != null) {
      userName = user!.displayName!;
      final _usersInfo =
          FirebaseFirestore.instance.collection('Users').doc(user!.uid);
      List<String> _recipesId = [];
      List<String> _recentRecipesId = [];

      _usersInfo.snapshots().map((snapshot) {
        final _data = snapshot.data()!;
        cookCount = _data['cook_count'] as int;
        _recipesId = _data['you_upload_recipes_id'] as List<String>;
        _recentRecipesId = _data['recent_recipes_id'] as List<String>;
      });

      for (String recipeId in _recipesId) {
        final _recipe =
            LoadRecipes.loadFirestoreAssetAt(recipeId).then((recipe) {
          uploadRecipes.add(recipe: recipe);
        });
      }

      for (String recipeId in _recentRecipesId) {
        final _recipe =
            LoadRecipes.loadFirestoreAssetAt(recipeId).then((recipe) {
          recentRecipes.add(recipe: recipe);
        });
      }
    }
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
          RecentRecipes(recipes: recentRecipes),
        ],
      ),
    );
  }
}
