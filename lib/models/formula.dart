import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:flutter/widgets.dart';
import 'package:study_buddy/gloabal.dart';

class Formula {
  String texString = "";
  int lineno = 1;
  Formula(this.texString, {this.lineno = 1});
  Widget render() => Container(
      height: 50 * lineno.toDouble(),
      child: TeXView(
          child: TeXViewDocument(
            texString,
            style: TeXViewStyle(
              height: 50,
            ),
          ),
          loadingWidgetBuilder: (context) => Container(
              height: 50,
              color: Colors.white,
              child: Center(
                child: Text('Rendering.....'),
              ))));
}

class FormulaPage {
  List<String> texString = [];
  FormulaPage(this.texString);
  Future<String> concat() async {
    String ans = r"";
    ans += r"<p>";
    for (var i in texString) {
      ans += i;
      ans += r"<p></p>";
    }
    ans += r"</p>";
    print(ans);
    return ans;
  }

  Widget render() => Scaffold(
      backgroundColor: pageback,
      body: FutureBuilder(
        future: concat(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.done) {
            return TeXView(
              child: TeXViewDocument(
                snap.data.toString(),
                style: TeXViewStyle(
                  backgroundColor: pageback,
                  padding: TeXViewPadding.only(
                    right: 10,
                    left: 10,
                    top: 5,
                    bottom: 5,
                  ),
                ),
              ),
              loadingWidgetBuilder: (context) => Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ));
}
