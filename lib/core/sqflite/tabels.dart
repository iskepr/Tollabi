import "package:abo_sadah/core/sqflite/mySql.dart";

Future<void> createTables() async {
  await MySqfLite().createTable("groups", {
    "id": "INTEGER PRIMARY KEY AUTOINCREMENT",
    "day1": "TEXT NOT NULL",
    "day2": "TEXT",
    "startTime": "REAL",
    "endTime": "REAL",
    "isAM": "INTEGER",
    "price": "REAL",
    "grade": "REAL",
  });

  await MySqfLite().createTable("students", {
    "id": "INTEGER PRIMARY KEY AUTOINCREMENT",
    "name": "TEXT NOT NULL",
    "phone": "TEXT",
    "groupId": "INTEGER REFERENCES groups(id) ON DELETE SET NULL",
  });

  await MySqfLite().createTable("tasks", {
    "id": "INTEGER PRIMARY KEY AUTOINCREMENT",
    "title": "TEXT",
    "score": "INTEGER",
    "time": "TEXT",
  });

  await MySqfLite().createTable("grades", {
    "id": "INTEGER PRIMARY KEY AUTOINCREMENT",
    "taskID": "INTEGER REFERENCES tasks(id) ON DELETE CASCADE",
    "score": "INTEGER",
    "groupID": "INTEGER REFERENCES groups(id)",
    "studentID": "INTEGER REFERENCES students(id) ON DELETE CASCADE",
  });
}
