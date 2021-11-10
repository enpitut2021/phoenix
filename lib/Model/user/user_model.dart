import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart' show rootBundle;

class UserModel {
  String name = "";
  int id = 0;
  int makenum = 0;
  List<int> friends = [];
  // List<int> recipeid = [];
  List<int> recentrecipe = [];

  Future<void> loadUserId() async{
    final String _loadData =
    await rootBundle.loadString('lib/Model/user/user_info.json');
    final jsonResponse = json.decode(_loadData);

    id = jsonResponse['id'];
  }

  void userFetch() async {
    String id = this.id.toString();
    await FirebaseFirestore.instance
                .collection('User')
                .doc(id)
                .get().then(
                  (value) => {
                    name = value.get('name'),
                    // friends = value.get('friends'),
                    // recentrecipe = value.get('recent_recipe')
                  }
                );
  }

  //  Map<String, dynamic> toJson() => {        
  //    'id': this.id,
  //   };

  void createId() async {
    final _store = FirebaseFirestore.instance;
    String id = "";
    await _store.collection('User').orderBy('id', descending: true).limit(1).get().then((value)=>{
      this.id = value.docs[0].get('id')+1,
      id = this.id.toString(),
      print(this.id)
    });
    _store.collection('User').doc(id).set({
      'name': '鬼岡',
      'id' : this.id
    });
    // final _filepath = File('lib/Model/user/user_info.json');

    // List<Map> ids = [];

    // _filepath.writeAsString(json.decode(ids));
  }
    
}
