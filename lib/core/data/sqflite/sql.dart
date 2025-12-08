import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class MySqfLite {
  static final MySqfLite _instance = MySqfLite._internal();
  factory MySqfLite() => _instance;
  MySqfLite._internal();

  late Database _database;

  // Initialize the database
  static Future<void> init(String dbName) async {
    _instance._database = await openDatabase(
      join(await getDatabasesPath(), dbName),
      version: 1,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: (db, version) async {},
    );
  }

  // Method to create a table dynamically
  Future<void> createTable(String table, Map<String, String> columns) async {
    final columnDefs = columns.entries
        .map((e) => '${e.key} ${e.value}')
        .join(', ');
    await _database.execute('CREATE TABLE IF NOT EXISTS $table ($columnDefs)');
  }

  // Insert a row into the dynamically created table
  Future<int> insert(String table, Map<String, dynamic> data) async {
    return await _database.insert(table, data);
  }

  // Query rows from the table
  Future<List<Map<String, dynamic>>> query(
    String table, {
    String? where,
    List<dynamic>? whereArgs,
    int? limit,
    int? offset,
  }) async {
    return await _database.query(
      table,
      where: where,
      whereArgs: whereArgs,
      limit: limit,
      offset: offset,
    );
  }

  // Update a row in the table
  Future<void> update(
    String table,
    Map<String, dynamic> data, {
    required String whereClause,
    required List<dynamic> whereArgs,
  }) async {
    await _database.update(
      table,
      data,
      where: whereClause,
      whereArgs: whereArgs,
    );
  }

  // Delete a row from the table
  Future<void> delete(
    String table, {
    required String whereClause,
    required List<dynamic> whereArgs,
  }) async {
    await _database.delete(table, where: whereClause, whereArgs: whereArgs);
  }

  // Create One-to-One Relationship Table
  Future<void> createOneToOneTable(
    String table, {
    required String referenceTable,
    required String foreignKey,
    required Map<String, String> columns,
  }) async {
    final columnDefs = columns.entries
        .map((e) => '${e.key} ${e.value}')
        .join(', ');
    await _database.execute(
      'CREATE TABLE IF NOT EXISTS $table ($columnDefs, FOREIGN KEY ($foreignKey) REFERENCES $referenceTable(id))',
    );
  }

  // Create One-to-Many Relationship Table
  Future<void> createOneToManyTable(
    String table, {
    required String referenceTable,
    required String foreignKey,
    required Map<String, String> columns,
  }) async {
    final columnDefs = columns.entries
        .map((e) => '${e.key} ${e.value}')
        .join(', ');
    await _database.execute(
      'CREATE TABLE IF NOT EXISTS $table ($columnDefs, FOREIGN KEY ($foreignKey) REFERENCES $referenceTable(id))',
    );
  }

  // Create Many-to-Many Relationship Table
  Future<void> createManyToManyTable({
    required String junctionTableName,
    required String table1,
    required String table2,
    required String foreignKey1,
    required String foreignKey2,
  }) async {
    await _database.execute(
      'CREATE TABLE IF NOT EXISTS $junctionTableName ($foreignKey1 INTEGER, $foreignKey2 INTEGER, '
      'FOREIGN KEY ($foreignKey1) REFERENCES $table1(id), '
      'FOREIGN KEY ($foreignKey2) REFERENCES $table2(id))',
    );
  }

  // Query by ID
  Future<Map<String, dynamic>?> queryById(String table, int id) async {
    final result = await _database.query(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
    return result.isNotEmpty ? result.first : null;
  }

  // Raw SQL Query
  Future<List<Map<String, dynamic>>> rawQuery(
    String sql, [
    List<dynamic>? arguments,
  ]) async {
    return await _database.rawQuery(sql, arguments);
  }

  // Count Rows
  Future<int> count(String table) async {
    return Sqflite.firstIntValue(
          await _database.rawQuery('SELECT COUNT(*) FROM $table'),
        ) ??
        0;
  }

  // Bulk Insert
  Future<void> bulkInsert(
    String table,
    List<Map<String, dynamic>> dataList,
  ) async {
    final batch = _database.batch();
    for (var data in dataList) {
      batch.insert(table, data);
    }
    await batch.commit();
  }

  // Perform Transaction
  Future<void> transaction(
    Future<void> Function(Transaction txn) action,
  ) async {
    await _database.transaction((txn) async {
      await action(txn);
    });
  }

  // Batch Operation
  Future<void> performBatch(Function(Batch batch) action) async {
    final batch = _database.batch();
    action(batch);
    await batch.commit();
  }

  // Join Queries
  Future<List<Map<String, dynamic>>> joinQuery(
    String table1,
    String table2,
    String joinCondition, {
    String? where,
    List<dynamic>? whereArgs,
  }) async {
    final sql =
        'SELECT * FROM $table1 INNER JOIN $table2 ON $joinCondition ${where != null ? 'WHERE $where' : ''}';
    return await _database.rawQuery(sql, whereArgs);
  }

  // Pagination Support
  Future<List<Map<String, dynamic>>> paginate(
    String table,
    int pageSize,
    int pageIndex,
  ) async {
    final offset = pageSize * pageIndex;
    return await _database.query(table, limit: pageSize, offset: offset);
  }

  // Aggregate Functions
  Future<int?> sum(String table, String column) async {
    return Sqflite.firstIntValue(
      await _database.rawQuery('SELECT SUM($column) FROM $table'),
    );
  }

  Future<int?> min(String table, String column) async {
    return Sqflite.firstIntValue(
      await _database.rawQuery('SELECT MIN($column) FROM $table'),
    );
  }

  Future<int?> max(String table, String column) async {
    return Sqflite.firstIntValue(
      await _database.rawQuery('SELECT MAX($column) FROM $table'),
    );
  }

  Future<double?> avg(String table, String column) async {
    final result = await _database.rawQuery('SELECT AVG($column) FROM $table');
    if (result.isNotEmpty && result.first.values.first != null) {
      return (result.first.values.first as num).toDouble();
    }
    return null;
  }

  // Index Creation
  Future<void> createIndex(String table, String columnName) async {
    await _database.execute(
      'CREATE INDEX IF NOT EXISTS ${table}_${columnName}_idx ON $table($columnName)',
    );
  }
}
