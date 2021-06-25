import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:study_buddy/contents.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:study_buddy/main_page.dart';

void main() {
  runApp(Root());
}

/*
* This widget is initializing the firebase api and then navigating 
* to MainPage widget
*/
class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: FutureBuilder(
            future: Firebase.initializeApp(),
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.done) {
                return MainPage();
              }
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.black38,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
