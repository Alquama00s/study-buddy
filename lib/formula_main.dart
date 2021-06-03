import 'package:flutter/material.dart';
import 'package:study_buddy/models/formula.dart';
import 'package:study_buddy/packages/firebase_driver.dart';

class FormMain extends StatelessWidget {
  FormMain({Key? key}) : super(key: key);
  static List<String> lists = [];
  FormulaPage page = FormulaPage(lists);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getFire('formula/math'),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.done) {
          page = FormulaPage(
              ((snap.data as Map)['booklet']['quadratic equations'] as List)
                  .map((e) => e.toString())
                  .toList());
          return page.render();
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
