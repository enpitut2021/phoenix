import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SuggestMenus(),
    );
  }
}

class SuggestMenus extends StatefulWidget {
  const SuggestMenus({Key? key}) : super(key: key);

  @override
  _SuggestMenusState createState() => _SuggestMenusState();
}

class _SuggestMenusState extends State<SuggestMenus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ランダムにメニューを提案'),
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    //このリストはあとでjsonからとってくるようにする
    final List<String> Menus = <String>['カレーライス', '親子丼', 'ハンバーグ'];
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: Menus.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 50,
          child: _tile(Menus[index]),
        );
      },
    );
  }

  Widget _tile(String menu) {
    return Card(
      child: ListTile(title: Text(menu)),
    );
  }
}
