import 'package:flutter/material.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('プロフィール'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => {},
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: const Text(
              "名前",
              style: TextStyle(fontSize: 20),
            ),
            alignment: Alignment.center,
            color: Colors.orange,
          ),
          _goto_friedlist_or_registerrecipe(context),
          Container(
            child: const Text(
              "最近作ったメニュー",
              style: TextStyle(fontSize: 20),
            ),
            alignment: Alignment.center,
            color: Colors.orange,
          ),
          _recentlyReciped(<int>[1, 2, 3, 4, 5, 6, 7, 8, 9])
        ],
      ),
    );
  }
}

// ignore: non_constant_identifier_names
Widget _goto_friedlist_or_registerrecipe(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Container(
        child: ElevatedButton(
          child: const Icon(Icons.person),
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            shape: const CircleBorder(
              side: BorderSide(
                color: Colors.black,
                width: 1,
                style: BorderStyle.solid,
              ),
            ),
          ),
          onPressed: () {
            Navigator.pushNamed((context), '/friendList');
          },
        ),
        alignment: Alignment.center,
      ),
      Container(
        child: Row(
            children: const <Widget>[Icon(Icons.restaurant), Text(": 15回")]),
        alignment: Alignment.center,
      ),
      Container(
        child: ElevatedButton(
          child: const Icon(Icons.document_scanner_sharp),
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            shape: const CircleBorder(
              side: BorderSide(
                color: Colors.black,
                width: 1,
                style: BorderStyle.solid,
              ),
            ),
          ),
          onPressed: () {
            Navigator.pushNamed((context), '/registerPage');
          },
        ),
        alignment: Alignment.center,
      ),
    ],
  );
}

Widget _recentlyReciped(List<int> ids) {
  return Expanded(
      child: GridView.count(
    crossAxisCount: 3,
    children: List.generate(9, (index) {
      return Container(
          child: Text('$index'),
          color: Colors.grey,
          alignment: Alignment.center,
          margin: const EdgeInsets.fromLTRB(5, 5, 5, 5));
    }),
  ));
}
