import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

class UserModel {
  String name = "";
  int id = 0;
  int makenum = 0;
  List<int> friends = [];
  // List<int> recipeid = [];
  List<int> recentrecipe = [];

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/user_info.json');
  }

  Future<void> loadUserId() async {
    try {
      File _filepath = await _localFile;
      String _loadData = await rootBundle.loadString(_filepath.path);
      final jsonResponse = json.decode(_loadData);

      id = jsonResponse['id'];
    } catch (e) {
      print(e);
    }
  }

  void userFetch() async {
    String id = this.id.toString();
    await FirebaseFirestore.instance
        .collection('User')
        .doc(id)
        .get()
        .then((value) => {
              name = value.get('name'),
              // friends = value.get('friends'),
              // recentrecipe = value.get('recent_recipe')
            });
  }

  void createId(String name) async {
    final _store = FirebaseFirestore.instance;
    String id = "";
    await _store
        .collection('User')
        .orderBy('id', descending: true)
        .limit(1)
        .get()
        .then((value) => {
              this.id = value.docs[0].get('id') + 1,
              id = this.id.toString(),
            });

    _store.collection('User').doc(id).set({'name': name, 'id': this.id});

    File _filepath = await _localFile;
    Map<String, dynamic> ids = {'id': this.id};
    _filepath.writeAsString(json.encode(ids));
  }

  int getID() {
    return id;
  }
}
