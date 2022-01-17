import 'package:flutter/material.dart';
import 'package:phoenix/Model/recipe/recipe_models.dart';

class ProfillOption extends StatefulWidget {
  Recipes uploadRecipes;
  int cookCount;

  ProfillOption(
      {Key? key, required this.cookCount, required this.uploadRecipes})
      : super(key: key);

  @override
  _ProfillOptionState createState() => _ProfillOptionState();
}

class _ProfillOptionState extends State<ProfillOption> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // Container(
        //   child: ElevatedButton(
        //     child: const Icon(Icons.person),
        //     style: ElevatedButton.styleFrom(
        //       primary: Colors.white,
        //       shape: const CircleBorder(
        //         side: BorderSide(
        //           color: Colors.black,
        //           width: 1,
        //           style: BorderStyle.solid,
        //         ),
        //       ),
        //     ),
        //     onPressed: () {
        //       Navigator.pushNamed((context), '/friendList');
        //     },
        //   ),
        //   alignment: Alignment.center,
        // ),
        Container(
          child: Row(children: <Widget>[
            const Icon(Icons.restaurant),
            Text(widget.cookCount.toString())
          ]),
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
              Navigator.pushNamed((context), '/registerPage',
                  arguments: widget.uploadRecipes);
            },
          ),
          alignment: Alignment.center,
        ),
      ],
    );
  }
}
