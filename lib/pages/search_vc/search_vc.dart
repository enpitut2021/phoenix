import 'package:flutter/material.dart';
import '../../data/operatelist.dart';

class SearchVC extends StatefulWidget {
  const SearchVC({Key? key}) : super(key: key);

  @override
  _SearchVCState createState() => _SearchVCState();
}

class _SearchVCState extends State<SearchVC> {
  List<String> searchwords = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('材料を指定'),
      ),
      body: Column(
        children: [
          TextFormField(
            onFieldSubmitted: (String str) {
              if (str != '') {
                setState(() {
                  searchwords.add(str);
                });
              }
            },
          ),
          // ignore: avoid_unnecessary_containers
          Container(
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: _searchList(searchwords),
            ),
          ),
          // ignore: sized_box_for_whitespace
          Container(
            width: double.infinity,
            child: ElevatedButton(
              child: const Text("決定"),
              onPressed: () {
                Navigator.of(context).pop(SendData(searchwords));
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _searchList(List<String> searchwords) {
    List<Widget> searchwordswidgets = [];
    for (var str in searchwords) {
      searchwordswidgets.add(
        Card(
          child: ListTile(
            tileColor: Colors.orange.shade200,
            title: Text(str),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: (() {
                setState(() {
                  searchwords.remove(str);
                });
                // ignore: avoid_print
                print(searchwords);
              }),
            ),
          ),
        ),
      );
    }
    return searchwordswidgets;
  }
}
