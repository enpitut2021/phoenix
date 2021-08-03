import 'dart:math' as math;

List shuffle(List items) {
  var random = new math.Random();
  for (var i = items.length - 1; i > 0; i--) {
    var n = random.nextInt(i + 1);
    var temp = items[i];
    items[i] = items[n];
    items[n] = temp;
  }
  return items;
}

String katakanaToHira(String str) {
  return str.replaceAllMapped(new RegExp("[ァ-ヴ]"),
      (Match m) => String.fromCharCode(m.group(0)!.codeUnitAt(0) - 0x60));
}
