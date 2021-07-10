import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:study_buddy/packages/functions.dart';
import 'package:study_buddy/version_check.dart';
import 'package:flutter/services.dart';

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
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.grey[800], // navigation bar color
      statusBarColor: Colors.grey[800], // status bar color
    ));
    return MaterialApp(
      theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.purple,
          fontFamily: 'Roboto'),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: FutureBuilder(
            future: Init(),
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
