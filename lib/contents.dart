import 'package:flutter/material.dart';
import 'package:study_buddy/models/book.dart';
import 'package:study_buddy/page.dart';
import 'dart:math';
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
              return ContentDisp(
                content: snap.data as List,
                book: book,
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

class ContentDisp extends StatefulWidget {
  ContentDisp({Key? key, required this.content, required this.book})
      : super(key: key);
  List content;
  Book book;
  @override
  _ContentDispState createState() => _ContentDispState();
}

class _ContentDispState extends State<ContentDisp> {
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
            itemCount: widget.content.length,
            itemBuilder: (context, i) => GestureDetector(
              onTap: () {
                //print((snap.data as Map)['booklets'][i]);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Page_(
                              book: widget.book,
                              chapter: widget.content[i],
                            )));
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 80,
                color: Colors.grey[100],
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            widget.content[i],
                            style:
                                TextStyle(fontSize: 30, color: Colors.purple),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          busy = !busy;
                          setState(() {});
                          await widget.book.deleteChapter(widget.content[i]);
                          widget.content.removeAt(i);
                          busy = !busy;
                          setState(() {});
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
                    ],
                  ),
                ),
              ),
            ),
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
                await widget.book.createChapter(text);
                busy = !busy;
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
