import 'package:study_buddy/models/local_firebase/firestore.dart';

import 'local_firebase/firebase.dart';

//LocalFirestore? store;
Future<void> init() async {
  //var base = LocalFirebase();
  //await base.init();
  //await base.addApp('buddy');
  //store = LocalFirestore('buddy');
}

Future<void> tests() async {
  //var base = LocalFirebase();
  //await base.init();
  //await base.addApp('buddy');
  var store = LocalFirestore('buddy');
  print('hello');
  print(store);
  //await store.init();
  //store.addCollection('test');
  store.collref("", 'test').addDoc('doctest');
}
