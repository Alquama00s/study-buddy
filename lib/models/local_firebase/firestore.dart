import "package:hive/hive.dart";
import 'package:study_buddy/models/local_firebase/algo.dart';
import 'package:study_buddy/models/local_firebase/doc_controller.dart';
//import 'package:study_buddy/models/local_firebase/collections.dart';
part 'document.dart';
part 'collections.dart';

class LocalFirestore {
  List<String> _rootCollections = [];
  Box? _schemabox;
  String _name;
  LocalFirestore(this._name);

  Future<void> init() async {
    _schemabox = await Hive.openBox('fire-.$_name');
    _schemabox!.put("fire-.rootcollection", _rootCollections);
  }

  void addCollection(String name) {
    //_schemabox = Hive.box('fire-.$_name');
    _rootCollections = _schemabox!.get("fire-.rootcollection");
    if (!_rootCollections.contains(name)) {
      _rootCollections.add(name);
      _schemabox!.put('lfire-.$name', {});
    } else {
      print('collection allready there');
    }
  }

  void deleteCollection(String name) {
    _rootCollections = _schemabox!.get("fire-.rootcollection");
    if (_rootCollections.contains(name)) {
      _rootCollections.remove(name);
      _schemabox!.delete('lfire-.$name');
    } else {
      print('collection allready there');
    }
  }

  Document docref(String address) {
    return Document(address);
  }

  Collection collref(String rootAddress, String name) {
    _schemabox = Hive.box('fire-.$_name');
    var coll;
    if (rootAddress == "") {
      List<String> list = _schemabox!.get('fire-.rootcollection');
      if (list.contains(name)) {
        //var map = _schemabox!.get('lfire-.$name');
        coll = Collection(rootAddress, name);
        return coll;
      }
      return coll;
    } else {
      var doc = Document(rootAddress);
      return doc.getCollection(name);
    }
  }
}

String addressParser(String address) {
  return hashGen(address);
}
