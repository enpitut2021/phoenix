import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final FirebaseAuth user = FirebaseAuth.instance;
  String name = "";
  String id = "";
  int makenum = 0;
  List<String> friends = [];
  List<String> recipeid = [];
  List<String> recentrecipeid = [];

  Future<void> createAccount(
      {required String email,
      required String password,
      required String name}) async {
    try {
      await user
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        FirebaseFirestore.instance.collection('User').doc(value.user!.uid).set({
          'makenum': 0,
          'friends': [],
          'recipeid': [],
          'recentrecipedid': []
        });
      });
      await user.currentUser!.updateDisplayName("displayName");
    } catch (e) {
      // ignore: avoid_print
      print("登録に失敗");
    }
  }

  Future<void> login({required String email, required String password}) async {
    try {
      await user
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        name = value.user!.displayName!;
        id = value.user!.uid;
      });
    } catch (e) {
      // ignore: avoid_print
      print("ログインに失敗");
    }
    await FirebaseFirestore.instance
        .collection('User')
        .doc(id)
        .get()
        .then((value) {
      makenum = value.get('makenum');
      friends = value.get('friends');
      recipeid = value.get('recipeid');
      recentrecipeid = value.get('recentrecipedid');
    });
  }

  void addFriendsID(String id) {
    friends.add(id);
  }

  void addRecipesID(String id) {
    recipeid.add(id);
  }

  void addRecentRecipeID(String id) {
    recentrecipeid.add(id);
  }

  String getID() {
    return id;
  }
}
