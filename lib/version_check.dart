import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:study_buddy/gloabal.dart';
import 'package:study_buddy/main_page.dart';
import 'package:study_buddy/packages/firebase_driver.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

/**
 * this widget checks version if it is updated 
 * or not
 */
class Version extends StatelessWidget {
  Version({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: getFire('schema/app'),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.done) {
              if ((snap.data as Map)["error"] == 1) {
                return Center(
                  child: Icon(Icons.error),
                );
              }
              if ((snap.data as Map)[version] == null) {
                return Center(
                  child: Column(
                    children: [
                      Text('This version is obselete!'),
                      TextButton(onPressed: () {}, child: Text('update'))
                    ],
                  ),
                );
              } else if ((snap.data as Map)[version]) {
                SchedulerBinding.instance!.addPostFrameCallback((_) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => MainPage()),
                      (route) => false);
                });
                return Container();
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('You are running an outdated version of app!'),
                      TextButton(onPressed: () {}, child: Text('update')),
                      TextButton(
                          onPressed: () => Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainPage()),
                              (route) => false),
                          child: Text('Skip'))
                    ],
                  ),
                );
              }
            } else if (snap.hasError) {
              return Center(
                child: Icon(Icons.error),
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
