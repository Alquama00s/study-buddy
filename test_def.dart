void main(List<String> args) {
  List<String> alpha = [
    r'\( a \ne 0 \)',
    r'\( a \ne 0 \)',
    r'\( a \ne 0 \)',
    r'\( a \ne 0 \)'
  ];
  String s = r"";
  for (var i in alpha) {
    s += i;
    s += "\n";
  }
  print(s);
}
