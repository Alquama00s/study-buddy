import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:study_buddy/models/book.dart';
import 'package:study_buddy/models/formula.dart';

/*
* This widget fetches all tex data from Db and
* passes them to formula to display
*/
class Page_ extends StatelessWidget {
  Page_({Key? key, required this.book, required this.chapter})
      : super(key: key);
  final Book book;
  final String chapter;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: book.getChapter(chapter),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.done) {
              return Formula(snap.data.toString()).render();
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
