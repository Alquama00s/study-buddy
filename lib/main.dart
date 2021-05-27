import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:study_buddy/formula_main.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
        future: Hive.initFlutter("buddy"),
        builder: (ctx, snap) {
          if (snap.connectionState == ConnectionState.done) {
            return FormMain();
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ))),
    );
  }
}
