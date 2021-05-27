import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:study_buddy/models/local_firebase/firestore.dart';
import 'package:study_buddy/models/local_firebase/local_firebase_io.dart';

class LocalFirebase extends LocalFirebaseIO {
  LocalFirebase();

  Future<void> init() async {
    if (!await firebasExists()) {
      await firebaseConfig!.writeAsString(jsonEncode({"Apps": []}));
      await Hive.initFlutter("firebase");
    }
  }

  Future<LocalFirestore> getLocalFirestore(String appname) async {
    return LocalFirestore(appname);
  }

  Future<void> addApp(String appname) async {
    await loadMap();
    configMap['Apps'].add(appname);
    firebaseConfig!.writeAsString(jsonEncode(configMap));
    await Hive.openBox(appname);
  }
}

class Documents {
  String address;
  Box<dynamic>? doc;
  Documents(this.address);
  void init() async {
    doc = await Hive.openBox(address);
  }

  bool isInitialized() {
    return doc != null;
  }
}

class Collection {
  String address;
  Collection(this.address);
  List<String> doclist = [];
  void addDoc(String name) async {
    if (!doclist.contains(name)) {
      doclist.add(name);
      await Hive.openBox('$address/$name');
    }
  }
}
