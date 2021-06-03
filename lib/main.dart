import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:study_buddy/formula_main.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(Root());
}

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
                return FormMain();
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
