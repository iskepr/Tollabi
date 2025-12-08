import "package:abo_sadah/core/data/sqflite/sql.dart";

Future<void> createTables() async {
  await MySqfLite().createTable("groups", {
    "id": "INTEGER PRIMARY KEY AUTOINCREMENT",
    "price": "REAL NOT NULL",
    "grade": "REAL NOT NULL DEFAULT 10",
  });

  await MySqfLite().createTable("time_groups", {
    "id": "INTEGER PRIMARY KEY AUTOINCREMENT",
    "day": "TEXT NOT NULL",
    "startTime": "TEXT NOT NULL",
    "endTime": "TEXT NOT NULL",
    "group_id": "INTEGER REFERENCES groups(id) ON DELETE CASCADE",
  });

  await MySqfLite().createTable("students", {
    "id": "INTEGER PRIMARY KEY AUTOINCREMENT",
    "name": "TEXT NOT NULL",
    "phone": "TEXT",
    "group_id": "INTEGER REFERENCES groups(id) ON DELETE SET NULL",
    "created_time": "TEXT",
  });

  await MySqfLite().createTable("attendances", {
    "id": "INTEGER PRIMARY KEY AUTOINCREMENT",
    "student_id": "INTEGER REFERENCES students(id) ON DELETE CASCADE",
    "group_id": "INTEGER REFERENCES groups(id) ON DELETE CASCADE",
    "grade": "REAL",
    "status": "INTEGER DEFAULT 0",
    "created_time": "TEXT",
  });

  await MySqfLite().createTable("expenses", {
    "id": "INTEGER PRIMARY KEY AUTOINCREMENT",
    "title": "TEXT",
    "description": "TEXT",
    "amount": "REAL",
    "created_time": "TEXT",
  });
}
