import 'package:hive/hive.dart';
import 'algo.dart';

abstract class DocumentController {
  Box? _hivebox;
  final String collections = 'fire-.collections';
  Future<void> init(String address) async {
    try {
      _hivebox = Hive.box(hashGen(address));
      address = _hivebox!.get('fire-.address');
    } catch (_) {
      _hivebox = await Hive.openBox(hashGen(address));
      _hivebox!.put('$collections-ids', []);
      _hivebox!.put('fire-.address', address);
    }
  }

  String getAddress() {
    return _hivebox!.get('fire-.address');
  }

  String addressParser(String address) {
    return hashGen(address);
  }

  Box getbox() {
    return _hivebox!;
  }

  void close() {
    try {
      _hivebox!.close();
    } catch (_) {}
  }

  void addData(key, value) {
    _hivebox!.put(key, value);
  }

  void deleteData(key) {
    _hivebox!.delete(key);
  }

  dynamic getData(key) {
    return _hivebox!.get(key);
  }

  void deleteCompletely() {
    _hivebox!.deleteFromDisk();
  }
}
