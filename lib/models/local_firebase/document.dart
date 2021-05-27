import 'package:hive/hive.dart';

class Document {
  String id;
  Box? _hivebox;
  Document(this.id);

  Future<void> init() async {
    _hivebox = await Hive.openBox(id);
  }

  void add(Map<String, dynamic> data) {
    data.forEach((key, value) {
      _hivebox!.put(key, value);
    });
  }

  void delete(key) {
    _hivebox!.delete(key);
  }
}
