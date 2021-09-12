import 'dart:async';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class SembastDatabase { 
  static final SembastDatabase _singleton = SembastDatabase._();

  static SembastDatabase get instance => _singleton;

  // Completer is used for transforming synchronous code into asynchronous code.
  final Map<String, Completer<Database>> _dbOpenCompleter = {};

  // A private constructor. Allows us to create instances of AppDatabase
  // only from within the AppDatabase class itself.
  SembastDatabase._();

  // Database object accessor
  Future<Database> database(String boxName) async {
    // If completer is null, AppDatabaseClass is newly instantiated,
    // so database is not yet opened
    if (_dbOpenCompleter[boxName] == null) {
      _dbOpenCompleter[boxName] = Completer();
      // Calling _openDatabase will also complete the completer
      // with database instance
      await _openDatabase(boxName);
    }
    // If the database is already opened, awaiting the future will
    // happen instantly. Otherwise, awaiting the returned future
    // will take some time - until complete() is called
    // on the Completer in _openDatabase() below.
    return _dbOpenCompleter[boxName]!.future;
  }

  Future<void> _openDatabase(String boxName) async {
    // Get a platform-specific directory where persistent app data can be stored
    final appDocumentDir = await getApplicationDocumentsDirectory();
    // Path with the form: /platform-specific-directory/demo.db
    final dbPath = join(appDocumentDir.path, '${boxName}_Miles.db');

    final database = await databaseFactoryIo.openDatabase(dbPath);

    // Any code awaiting the Completer's future will now start executing
    _dbOpenCompleter[boxName]?.complete(database);
  }
}