import 'package:pdm_alfa/repositories/keys/sqflite.keys.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqfliteRepository {
  static final _databaseName = 'pdm.db';
  static final _databaseVersion = 1;

  SqfliteRepository._privateConstructor();
  static final SqfliteRepository instance =
      SqfliteRepository._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ${SqfliteKeys.customerTable} (
        ${SqfliteKeys.id} INTEGER PRIMARY KEY AUTOINCREMENT ,
        ${SqfliteKeys.customerName} TEXT NOT NULL,
        ${SqfliteKeys.customerPhone} TEXT NOT NULL,
        ${SqfliteKeys.customerEmail} TEXT NOT NULL,
        ${SqfliteKeys.customerDateOfBirth} DATE NOT NULL,
        ${SqfliteKeys.customerDeleted} INTEGER DEFAULT 0
      )
      ''');
  }
}
