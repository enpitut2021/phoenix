import 'package:flutter/material.dart';
import '../../data/operatelist.dart';

class SearchVC extends StatefulWidget {
  const SearchVC({Key? key}) : super(key: key);

  @override
  _SearchVCState createState() => _SearchVCState();
}

enum radiovalue { ingredient, spices } // キーワードの種類

class _SearchVCState extends State<SearchVC> {
  List<String> searchwords = [];
  String addkeyword = '';
  radiovalue? keywordtype = radiovalue.ingredient;

  //ドロップダウン用リスト
  List<DropdownMenuItem<int>> _items = [];
  int _selectedItem = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setItem();
    _selectedItem = _items[0].value!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('キーワードで絞り込み'),
      ),
      body: Column(
        children: [
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
              child: const Text("上記で絞り込む"),
              onPressed: () {
                Navigator.of(context).pop(SendData(searchwords));
              },
            ),
          ),
        ],
      ),
      // キーワードを入力するアラートを起動
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (context) {
            return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  title: const Text('キーワードをリストに追加'),
                  actions: <Widget>[
                    TextFormField(
                      onChanged: (String str) {
                        addkeyword = str;
                      },
                    ),
                    //種別ラジオボタン
                    Column(
                      children: <Widget>[
                        RadioListTile(
                          title: const Text('材料'),
                          value: radiovalue.ingredient,
                          groupValue: keywordtype,
                          onChanged: (radiovalue? value) => {
                            setState(() {
                              keywordtype = value;
                            }),
                          },
                        ),
                        RadioListTile(
                          title: const Text('調味料'),
                          value: radiovalue.spices,
                          groupValue: keywordtype,
                          onChanged: (radiovalue? value) => {
                            setState(() {
                              keywordtype = value;
                            }),
                          },
                        ),
                        Container(
                          child: DropdownButton(
                            items: _items,
                            value: _selectedItem,
                            onChanged: (int? value) {
                              setState((){
                                _selectedItem = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        child: const Text("追加"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ).then((context) {
          if (addkeyword != '') {
            setState(() {
              searchwords.add(addkeyword);
              addkeyword = '';
            });
          }
        }),
        child: const Icon(Icons.add),
      ),
    );
  }

  void setItem(){
    for(int i = 0; i <= 60; i++){
      if(i == 0){
        _items.add(DropdownMenuItem(
          child: const Text("調理時間"),
          value: i
          ),
        );
      } else {
        _items.add(DropdownMenuItem(
          child: Text(i.toString()),
          value: i
          ),
        );
      }
    }
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
