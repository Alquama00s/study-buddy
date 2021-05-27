import "package:hive/hive.dart";

class LocalFirestore {
  List<String> _rootCollections = [];
  Box? _hivebox;
  String _name;
  LocalFirestore(this._name);

  Future<void> init() async {
    _hivebox = await Hive.openBox(_name);
    _hivebox!.put("collectionlist", _rootCollections);
  }
  Future<voiud>
}
