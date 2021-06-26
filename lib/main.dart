import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:study_buddy/version_check.dart';

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
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: FutureBuilder(
            future: Firebase.initializeApp(),
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.done) {
                return Version();
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
