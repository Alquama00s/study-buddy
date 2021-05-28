import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:study_buddy/formula_main.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:study_buddy/models/firebase_driver.dart';

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
            future: init(),
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.done) {
                return Center(
                  child: MaterialButton(
                    onPressed: () async {
                      await tests();
                    },
                    child: Text('start'),
                  ),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
