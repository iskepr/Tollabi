import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDB {
  static Database? _db;
  final String? table;

  SqlDB._internal({this.table});
  factory SqlDB() => SqlDB._internal();

  static Future<SqlDB> from(String table) async {
    final instance = SqlDB._internal(table: table);
    await instance._intialDB();
    return instance;
  }

  _intialDB() async {
    if (_db != null) return;
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, "aboSadah.db");
    Database myDB = await openDatabase(path, onCreate: _onCreateDB, version: 1);
    return myDB;
  }

  void _onCreateDB(Database db, int version) async {
    db.execute("""
      CREATE TABLE "users"(
        "id" INTEGER PRIMARY KEY AUTOINCREMENT,
        "name" TEXT,
        "email" TEXT,
        "password" TEXT
      )
      """);
  }

  Future<int> insert({required Map<String, dynamic> data}) async {
    if (table == null) throw " لم يتم تحديد الجدول";
    return await _db!.insert(table!, data);
  }

  Future<List<Map<String, dynamic>>> select({
    List<String>? columns,
    String? where,
    List<dynamic>? whereArgs,
  }) async {
    if (table == null) throw " لم يتم تحديد الجدول";
    return await _db!.query(
      table!,
      columns: columns,
      where: where,
      whereArgs: whereArgs,
    );
  }
}

SqlDB sqll = SqlDB();
