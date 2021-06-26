import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:study_buddy/edit.dart';
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
  String text = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: book.getChapter(chapter),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.done) {
              text = snap.data.toString();
              return Formula(text).render();
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Edit(text: text)));
        },
        child: Icon(Icons.edit),
      ),
    );
  }
}
