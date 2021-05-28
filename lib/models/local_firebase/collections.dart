part of './firestore.dart';

class Collection extends DocumentController {
  String _name, _rootAddress;
  Map<String, dynamic> collection;
  Collection(this._rootAddress, this._name, {this.collection = const {}}) {
    selfInit();
  }

  void selfInit() {
    init(_rootAddress);
    collection = getData('lfire-.$_name');
  }

  void updateSelf() {
    init(_rootAddress);
    addData('lfire-.$_name', collections);
  }

  void addDoc(String name) {
    selfInit();
    if (!collection['lfire-.docids'].contains(name)) {
      collection['lfire-.docids'].add(name);
      updateSelf();
      close();
      init(_rootAddress + "/$_name/" + name);
    } else
      print('already there');
  }

  void deleteDoc(String name) {
    selfInit();
    if (collection['lfire-.docids'].contains(name)) {
      collection['lfire-.docids'].remove(name);
      updateSelf();
      close();
      init(_rootAddress + "/$_name/" + name);
      deleteCompletely();
    } else
      print('not there');
  }
}
