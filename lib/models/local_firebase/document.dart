//import 'package:hive/hive.dart';
//import 'package:study_buddy/models/local_firebase/collections.dart';
part of './firestore.dart';

class Document extends DocumentController {
  String _address;

  Document(this._address) {
    init(_address);
  }

  Collection getCollection(String name) {
    var box = getbox();
    var map = box.get('lfire-.$name');
    var coll = Collection(_address, name, collection: map);
    return coll;
  }

  void add(Map<String, dynamic> data) {
    data.forEach((key, value) {
      if (key.substring(0, collections.length) != collections)
        addData(key, value);
      else
        print('$key is already used in schema');
    });
  }

  void addCollection(String name) {
    List<String> list = getData('$collections-ids');
    if (!list.contains(name)) {
      list.add(name);
      addData('$collections-ids', list);
      addData('lfire-.$name', {});
    } else {
      print('collection alraedy there');
    }
  }

  void deleteCollection(String name) {
    List<String> list = getData('$collections-ids');
    if (list.contains(name)) {
      list.remove(name);
      addData('$collections-ids', list);
      deleteData('lfire-.$name');
    } else {
      print('collection not there');
    }
  }

  void delete(String key) {
    if (key.substring(0, collections.length) != collections)
      deleteData(key);
    else
      print('cant delete schema');
  }
}
