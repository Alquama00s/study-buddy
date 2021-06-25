import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:study_buddy/contents.dart';
import 'package:study_buddy/models/book.dart';
import 'package:study_buddy/packages/firebase_driver.dart';

/*
* This widget fetches all the books from Db and
* displays them.
* Also navigates to Contents Widget
 */
class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: getFire('schema/db'),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.done) {
              return ListView.builder(
                itemCount: (snap.data as Map)['booklets'].length,
                itemBuilder: (context, i) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Contents(
                                    book:
                                        Book((snap.data as Map)['booklets'][i]),
                                  )));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 80,
                      color: Colors.grey[100],
                      child: Center(
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            (snap.data as Map)['booklets'][i],
                            style:
                                TextStyle(fontSize: 30, color: Colors.purple),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
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
