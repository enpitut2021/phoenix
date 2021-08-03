import 'package:flutter/material.dart';
import '../data/toolsForList.dart';
//import 'package:flappy_search_bar/flappy_search_bar.dart';

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
        title: Text('材料を指定'),
      ),
      body: Column(
        children: [
          TextFormField(
            onFieldSubmitted: (String str) {
              setState(() {
                searchwords.add(str);
              });
            },
          ),
          Container(
            child: ListView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: _searchList(searchwords),
            ),
          ),
          Container(
            width: double.infinity,
            child: ElevatedButton(
              child: Text("決定"),
              onPressed: () {
                Navigator.of(context).pop(SendData(searchwords));
              },
            ),
          ),
        ],
      ),

      // body: SafeArea(
      //   child: SearchBar<String>(
      //     searchBarPadding: EdgeInsets.symmetric(horizontal: 10),
      //     minimumChars: 1,
      //     hintText: 'SSSSEEEEEAAAAARRRRRRRCCCCCCHHHHHHH',
      //     cancellationWidget: Text("キャンセル"),
      //     placeHolder: Center(
      //       child: ListView(
      //         children: [Text("hello"), Text("aaaahogehogehoge")],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }

  List<Widget> _searchList(List<String> searchwords) {
    List<Widget> searchwordsWidgets = [];
    for (var str in searchwords) {
      searchwordsWidgets.add(
          Card(
            child: ListTile(
              title: Text(str),

            ),
          ),
      );
    }
    return searchwordsWidgets;
  }
}
