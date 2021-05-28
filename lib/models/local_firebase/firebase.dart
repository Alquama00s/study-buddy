import 'dart:convert';
import 'dart:io';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:study_buddy/models/local_firebase/firestore.dart';
import 'package:study_buddy/models/local_firebase/local_firebase_io.dart';

class LocalFirebase extends LocalFirebaseIO {
  LocalFirebase();

  Future<void> init() async {
    await ioInit();
    if (!await firebaseExists()) {
      await firebaseConfig!.writeAsString(jsonEncode({"Apps": []}));
    }
  }

  Future<LocalFirestore> getLocalFirestore(String appname) async {
    return LocalFirestore(appname);
  }

  Future<void> addApp(String appname) async {
    await loadMap();
    configMap['Apps'].add(appname);
    firebaseConfig!.writeAsString(jsonEncode(configMap));
    await await Hive.initFlutter("firebase-.$appname");
  }
}
