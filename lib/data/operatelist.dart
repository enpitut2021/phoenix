import 'dart:math' as math;

///listにすでにシャッフル関数あるがここの優位性は後々考える
List shuffle(List items) {
  var random = math.Random();
  for (var i = items.length - 1; i > 0; i--) {
    var n = random.nextInt(i + 1);
    var temp = items[i];
    items[i] = items[n];
    items[n] = temp;
  }
  return items;
}

//漢字ひらがな変換はjavaとswift別々にコードを書く必要がある。
String toHira(String str) {
  return str.replaceAllMapped(RegExp("[ァ-ヴ]"),
      (Match m) => String.fromCharCode(m.group(0)!.codeUnitAt(0) - 0x60));
}

class SendData {
  List<String> words;

  SendData(this.words);
}

class SendDataWithTime {
  List<String> words;
  int time;

  SendDataWithTime(this.words, this.time);
}
