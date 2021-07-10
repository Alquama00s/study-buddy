import 'dart:io';

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
              return BooksDisp(
                  books:
                      ((snap.data as Map)['booklets'] as List).cast<String>());
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

class BooksDisp extends StatefulWidget {
  BooksDisp({Key? key, required this.books}) : super(key: key);
  final List<String> books;
  @override
  _BooksDispState createState() => _BooksDispState();
}

class _BooksDispState extends State<BooksDisp> {
  bool active = false, busy = false;
  String text = "";
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              active = false;
            });
          },
          child: ListView.builder(
            itemCount: widget.books.length,
            itemBuilder: (context, i) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Contents(
                                book: Book(widget.books[i]),
                              )));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 80,
                  color: Colors.grey[100],
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              widget.books[i],
                              style:
                                  TextStyle(fontSize: 30, color: Colors.purple),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            setState(() {
                              busy = !busy;
                            });
                            await deleteBook(widget.books[i]);
                            setState(() {
                              busy = !busy;
                            });
                            sleep(Duration(milliseconds: 500));
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MainPage()),
                                (route) => false);
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            child: Icon(
                              Icons.delete,
                              size: 25,
                              color: Colors.purple,
                            ),
                          ),
                        ),
                      ]),
                ),
              );
            },
          ),
        ),
        Positioned(
          //duration: Duration(milliseconds: 500),
          bottom: 10,
          right: 11,
          child: AnimatedContainer(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              duration: Duration(milliseconds: 500),
              width: active ? MediaQuery.of(context).size.width - 20 : 70,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(70),
                color: Colors.purple,
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Name",
                  hintStyle: TextStyle(color: Colors.white, fontSize: 20),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                cursorHeight: 22,
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white, fontSize: 20),
                onChanged: (_) => text = _,
              )),
        ),
        Positioned(
          //duration: Duration(milliseconds: 500),
          bottom: 10,
          right: 10,
          child: GestureDetector(
            onTap: () async {
              if (active && text != "") {
                busy = !busy;
                setState(() {});
                await addBook(text);
                busy = !busy;
                sleep(Duration(milliseconds: 500));
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => MainPage()),
                    (route) => false);
              }
              active = !active;
              setState(() {});
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                  color: Colors.purple,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 5,
                      blurRadius: 15,
                      offset: Offset(2, 10), // changes position of shadow
                    ),
                  ]),
              child: busy
                  ? CircularProgressIndicator()
                  : Icon(
                      Icons.add,
                      size: 50,
                      color: Colors.white,
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
