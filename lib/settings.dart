import 'dart:io';

import 'package:flutter/material.dart';
import 'package:study_buddy/gloabal.dart';
import 'package:study_buddy/main_page.dart';
import 'package:study_buddy/packages/auth_driver.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool signbusy = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Center(
              child: Icon(Icons.account_box_rounded,
                  size: 150, color: Colors.white),
            ),
            gUser == null
                ? Center(
                    child: GestureDetector(
                      onTap: () async {
                        setState(() {
                          signbusy = !signbusy;
                        });
                        await signInWithGoogle();
                        setState(() {
                          signbusy = !signbusy;
                        });
                        sleep(Duration(milliseconds: 500));
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => MainPage()),
                            (route) => false);
                      },
                      child: signbusy
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Container(
                              alignment: Alignment.center,
                              width: 150,
                              height: 50,
                              color: Colors.white,
                              child: Text(
                                "Sign in",
                                style: TextStyle(
                                    color: Colors.purple,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                    ),
                  )
                : Container(
                    child: Text(
                      'Hello ${gUser!.displayName}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
            SizedBox(
              height: 100,
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(30),
              child: RichText(
                text: TextSpan(
                    text: "Study Buddy",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                          text: '\nVersion : $version',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.normal)),
                      TextSpan(
                          text:
                              '\n\nThis project is open source available at github.com/Alquama00s/study_buddy',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.normal)),
                      TextSpan(
                          text:
                              '\n\nIf you find a bug or got a suggestion feel free to create an issue',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.normal)),
                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
