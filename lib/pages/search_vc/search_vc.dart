import 'package:flutter/material.dart';

import '../../data/operatelist.dart';
import '../../common_widget/time_represent.dart';

class SearchVC extends StatefulWidget {
  const SearchVC({Key? key}) : super(key: key);

  @override
  _SearchVCState createState() => _SearchVCState();
}

enum radiovalue { ingredient, spices } // キーワードの種類

class _SearchVCState extends State<SearchVC> {
  int _time_bound = 100;
  List<String> searchwords = [];
  String addkeyword = '';
  radiovalue? keywordtype = radiovalue.ingredient;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('キーワードで絞り込み'),
      ),
      body: Column(
        children: [
          timeDropdownButtun(set_time_bound, '調理時間の上限'),
          TextFormField(
            //initialValue: '（例）卵',
            decoration: new InputDecoration(
                labelText: '（例）卵　醤油',
                hintStyle: TextStyle(color: Colors.white30)),
            onFieldSubmitted: (value) {
              if (value != '') {
                setState(() {
                  String tmp = toHira(value);
                  searchwords = tmp.split('　');
                });
              }
            },
          ),
          // ignore: avoid_unnecessary_containers
          // Container(
          //   child: ListView(
          //     physics: const NeverScrollableScrollPhysics(),
          //     shrinkWrap: true,
          //     children: _searchList(searchwords),
          //   ),
          // ),

          // ignore: sized_box_for_whitespace
          Container(
            width: double.infinity,
            child: ElevatedButton(
              child: const Text("上記で絞り込む"),
              onPressed: () {
                Navigator.of(context)
                    .pop(SendDataWithTime(searchwords, _time_bound));
              },
            ),
          ),
        ],
      ),
      // キーワードを入力するアラートを起動
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => showDialog(
      //     context: context,
      //     builder: (context) {
      //       return StatefulBuilder(
      //         builder: (context, setState) {
      //           return AlertDialog(
      //             title: const Text('キーワードをリストに追加'),
      //             actions: <Widget>[
      //               TextFormField(
      //                 onChanged: (String str) {
      //                   addkeyword = str;
      //                 },
      //               ),
      //               //種別ラジオボタン
      //               /*
      //               Column(
      //                 children: <Widget>[
      //                   RadioListTile(
      //                     title: const Text('材料'),
      //                     value: radiovalue.ingredient,
      //                     groupValue: keywordtype,
      //                     onChanged: (radiovalue? value) => {
      //                       setState(() {
      //                         keywordtype = value;
      //                       }),
      //                     },
      //                   ),
      //                   RadioListTile(
      //                     title: const Text('調味料'),
      //                     value: radiovalue.spices,
      //                     groupValue: keywordtype,
      //                     onChanged: (radiovalue? value) => {
      //                       setState(() {
      //                         keywordtype = value;
      //                       }),
      //                     },
      //                   ),
      //                 ],
      //               ),
      //               */
      //               Container(
      //                 width: double.infinity,
      //                 child: ElevatedButton(
      //                   child: const Text("追加"),
      //                   onPressed: () {
      //                     Navigator.pop(context);
      //                   },
      //                 ),
      //               ),
      //             ],
      //           );
      //         },
      //       );
      //     },
      //   ).then((context) {
      //     if (addkeyword != '') {
      //       setState(() {
      //         searchwords.add(addkeyword);
      //         addkeyword = '';
      //       });
      //     }
      //   }),
      //   child: const Icon(Icons.add),
      // ),
    );
  }

  void set_time_bound({required int time}) {
    _time_bound = time;
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
              }),
            ),
          ),
        ),
      );
    }
    return searchwordswidgets;
  }
}
