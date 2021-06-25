import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<Map<String, dynamic>> getFire(String docAddress) async {
  var doc = await FirebaseFirestore.instance.doc(docAddress).get();
  var data = doc.data();
  return data!;
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
