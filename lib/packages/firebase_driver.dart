import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<Map<String, dynamic>> getFire(String docAddress) async {
  try {
    var doc = await FirebaseFirestore.instance.doc(docAddress).get();
    var data = doc.data();
    return data ?? {"error": 1};
  } catch (_) {}
  return {"error": 1};
}

Future<List<String>> getDoc(String collectionAddress, String field) async {
  List<String> list = [];
  await FirebaseFirestore.instance
      .collection(collectionAddress)
      .get()
      .then((value) => {
            for (var i in value.docs) {list.add(i.data()[field])}
          });
  return list;
}

Future<void> addBook(String name) async {
  if (name != "") {
    await FirebaseFirestore.instance.collection('schema').doc('db').update({
      'booklets': FieldValue.arrayUnion([name])
    });
    await FirebaseFirestore.instance
        .collection(name)
        .add({'content': "<h1>$name</h1>", 'title': "Cover"});
  }
}

Future<void> deleteBook(String book) async {
  if (book != "") {
    await FirebaseFirestore.instance.collection('schema').doc('db').update({
      'booklets': FieldValue.arrayRemove([book])
    });
    await FirebaseFirestore.instance.collection(book).get().then((value) => {
          for (var ds in value.docs) {ds.reference.delete()}
        });
  }
}
