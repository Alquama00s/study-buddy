import 'package:flutter/material.dart';
import 'package:study_buddy/models/book.dart';
import 'package:study_buddy/page.dart';

/*
* This widget displays the chapters in a book 
* and navigates to Formula widget to display
* formula in a particular chapter
 */
class Contents extends StatelessWidget {
  Contents({Key? key, required this.book}) : super(key: key);
  final Book book;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: book.getContent(),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.done) {
              return ListView.builder(
                itemCount: (snap.data as List).length,
                itemBuilder: (context, i) => GestureDetector(
                  onTap: () {
                    //print((snap.data as Map)['booklets'][i]);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Page_(
                                  book: book,
                                  chapter: (snap.data as List)[i],
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
                          (snap.data as List)[i],
                          style: TextStyle(fontSize: 30, color: Colors.purple),
                        ),
                      ),
                    ),
                  ),
                ),
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
