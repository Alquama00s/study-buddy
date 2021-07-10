import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:study_buddy/gloabal.dart';

Future<void> Init() async {
  await Firebase.initializeApp();
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      gUser = null;
    } else {
      gUser = user;
    }
  });
}
