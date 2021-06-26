import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/*
 * this widget is to edit formulas inside pages
 */
class Edit extends StatelessWidget {
  Edit({Key? key, required this.text}) : super(key: key) {
    con = TextEditingController(text: text);
  }
  final String text;
  TextEditingController? con;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Expanded(
          child: Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              keyboardType: TextInputType.multiline,
              controller: con,
              maxLines: null,
              decoration: InputDecoration(
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none),
            ),
          ),
        ),
      ),
    );
  }
}
