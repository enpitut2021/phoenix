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
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: Text("名前"),
            alignment: Alignment.center,
            color: Colors.orange,
          ),
        ],
      ),
    );
  }
}

Widget _goto_friedlist_or_registerrecipe() {
  return Row(
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
          onPressed: () {},
        ),
        alignment: Alignment.center,
      ),
      Container(
        child: Icon(Icons.set_meal_sharp),
      ),
    ],
  );
}
