 import 'package:flutter/material.dart';
 import 'package:phoenix/common_widget/friendlistwidget.dart';

class FriendList extends StatefulWidget {
  const FriendList({Key? key}) : super(key: key);

  @override
  _SuggestFriendListState createState() => _SuggestFriendListState();
}

class _SuggestFriendListState extends State<FriendList> {
  List<int> friendid = [00000001, 00000009];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('フレンドリスト'),
      ),
      body: ListView(
        children:
          friendlisttile(friendid, 300, TextStyle(fontSize: 20), () => {Navigator.pushNamed(context, '/uploadrecipe')}), // 遷移先は友達のプロフィール
      ),
    );
  }
}
