import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:study_buddy/models/formula.dart';

/*
 * this widget is to edit formulas inside pages
 */
class Edit extends StatefulWidget {
  Edit({Key? key, required this.text}) : super(key: key) {
    _body = _textform(text, fun);
  }
  late String text;
  late Widget _body;
  void fun(String text) {
    this.text = text;
  }

  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: widget._body,
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: Colors.green,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  widget._body = _textform(widget.text, widget.fun);
                });
              },
              icon: Icon(
                Icons.mode_edit_outline_outlined,
                color: Colors.white,
              ),
              iconSize: 30,
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  widget._body = Formula(widget.text).render();
                });
              },
              icon: Icon(
                Icons.preview_outlined,
                color: Colors.white,
              ),
              iconSize: 30,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

Widget _textform(String text, Function fun) {
  TextEditingController con = TextEditingController(text: text);
  return Container(
    padding: EdgeInsets.all(10),
    child: TextFormField(
      keyboardType: TextInputType.multiline,
      controller: con,
      maxLines: null,
      decoration: InputDecoration(
          focusedBorder: InputBorder.none, enabledBorder: InputBorder.none),
      onChanged: (_) => fun(_),
    ),
  );
}
