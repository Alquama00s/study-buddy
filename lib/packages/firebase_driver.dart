import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<Map<String, dynamic>> getFire(String address) async {
  var doc = await FirebaseFirestore.instance.doc(address).get();
  var data = doc.data();
  return data!;
}
