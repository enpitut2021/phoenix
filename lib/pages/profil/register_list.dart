 import 'package:flutter/material.dart';
 import 'package:phoenix/common_widget/register_list_widget.dart';

class RegisterList extends StatefulWidget {
  const RegisterList({Key? key}) : super(key: key);

  @override
  _SuggestRegisterListState createState() => _SuggestRegisterListState();
}

class _SuggestRegisterListState extends State<RegisterList> {
  List<int> friendid = [00000001, 00000009];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('レシピリスト'),
      ),
      body: ListView(
        children:
          registerListTile(friendid, 300, TextStyle(fontSize: 20), () => {Navigator.pushNamed(context, '/uploadrecipe')}), // 遷移先は友達のプロフィール
      ),
    );
  }
}
