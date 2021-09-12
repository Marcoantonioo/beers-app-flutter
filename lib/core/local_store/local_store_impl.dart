import 'package:app_miles/app_miles.dart';
import 'package:app_miles/core/local_store/local_store.dart';
import 'package:app_miles/core/local_store/sembast_database.dart';
import 'package:sembast/sembast.dart';

class LocalStoreImpl implements LocalStore {
  Future<Database> get _db => SembastDatabase.instance.database(key!);
  final String? key;
  final StoreRef<String, String>? store;

  LocalStoreImpl({@required this.key}) : store = StoreRef(key!);

  @override
  Future<void> setValue<T>(String? key, T value) async {
    store!.record(key!).put(await _db, jsonEncode(value));
  }

  @override
  Future<T> getValue<T>(String key) async {
    return store!.record(key).get(await _db).then((stringjson) {
      if (stringjson == null) {
        return Future.value(null);
      }
      return jsonDecode(stringjson) as T;
    });
  }

  @override
  Future<void> delete(String key) async {
    return store!.record(key).delete(await _db);
  }
}
