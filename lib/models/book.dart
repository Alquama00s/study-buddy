import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:study_buddy/packages/firebase_driver.dart';

/*
 * A model for Book 
 * fetches all data from db
 */
class Book {
  String _name;
  List<String> _chapters = [];
  Book(this._name);
  Future<List<String>> getContent() async {
    _chapters = await getDoc(_name, 'title');
    return _chapters;
  }

  Future<String> getChapter(String ch) async {
    String data = "";
    await FirebaseFirestore.instance
        .collection(_name)
        .where('title', isEqualTo: ch)
        .get()
        .then((value) => data = value.docs[0].data()['content']);
    return data;
  }
}
