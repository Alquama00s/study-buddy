import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:study_buddy/gloabal.dart';

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
    await FirebaseFirestore.instance
        .collection('${gUser!.uid}')
        .doc('schema')
        .update({
      'booklets': FieldValue.arrayUnion([name])
    });
    await FirebaseFirestore.instance
        .doc('${gUser!.uid}/books')
        .collection(name)
        .add({
      'content': "<h1>$name</h1>" +
          r"$$a^2$$ $$x={-b \pm \sqrt{b^2-4ac}\over 2a}$$ \(ax^{12}+bz+c\) <li> \(\alpha \Alpha \epsilon \Epsilon \Beta \Tau \beta\) </li>",
      'title': "Cover"
    });
  }
}

Future<void> deleteBook(String book) async {
  if (book != "") {
    await FirebaseFirestore.instance
        .collection('${gUser!.uid}')
        .doc('schema')
        .update({
      'booklets': FieldValue.arrayRemove([book])
    });
    await FirebaseFirestore.instance.collection(book).get().then((value) => {
          for (var ds in value.docs) {ds.reference.delete()}
        });
  }
}

Future<Map> getBooks() async {
  Map<String, dynamic> data = {};
  if (gUser != null) {
    data = await getFire('${gUser!.uid}/schema');
  } else {
    data = await getFire('schema/db');
  }

  if (data['error'] == 1) {
    await FirebaseFirestore.instance
        .collection('${gUser!.uid}')
        .doc('schema')
        .set({'booklets': []});
    await FirebaseFirestore.instance
        .collection('${gUser!.uid}')
        .doc('books')
        .set({});
    return {"booklets": []};
  } else {
    return data;
  }
}
