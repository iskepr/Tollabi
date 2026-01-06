import "package:abo_sadah/features/dashboard/models/analysis_service.dart";
import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:abo_sadah/core/data/typs.dart";
import "package:abo_sadah/core/data/sqflite/sql.dart";

class AppData extends ChangeNotifier {
  final MySqfLite _db = MySqfLite();

  bool isFirstTime = false;
  List<GroupsEntity> groups = [];
  List<StudentsEntity> students = [];
  List<AttendancesEntity> attendances = [];
  List<ExpensesEntity> expenses = [];
  List<AnalysisEntity> analysisData = [];
  bool isLoading = true;

  AppData() {
    init();
  }

  Future<void> init() async {
    isLoading = true;
    final prefs = await SharedPreferences.getInstance();
    isFirstTime = prefs.getBool("isFirstTime") ?? true;

    final results = await Future.wait([
      _db.query("groups"),
      _db.query("time_groups"),
      _db.query("students"),
      _db.query("attendances"),
      _db.query("expenses"),
    ]);

    final rawGroups = results[0];
    final rawTimes = results[1];
    final rawStudents = results[2];
    final rawAttendances = results[3];
    final rawExpenses = results[4];

    students = rawStudents.map(StudentsEntity.fromMap).toList();
    attendances = rawAttendances.map(AttendancesEntity.fromMap).toList();
    expenses = rawExpenses.map(ExpensesEntity.fromMap).toList();

    groups = rawGroups.map((gMap) {
      final gId = gMap["id"];
      return GroupsEntity.fromMap({
        ...gMap,
        "students": rawStudents.where((s) => s["group_id"] == gId).toList(),
        "time_groups": rawTimes.where((t) => t["group_id"] == gId).toList(),
      });
    }).toList();

    updateAnalysis();
    isLoading = false;
    notifyListeners();
  }

  void updateAnalysis() {
    analysisData = AnalysisService.calculate(
      students,
      groups,
      expenses,
      attendances,
    );
    notifyListeners();
  }

  // Groups
  void addGroup(GroupsEntity group) async {
    int id = await MySqfLite().insert("groups", {
      "price": group.price,
      "grade": group.grade,
    });

    for (var timeGroup in group.timeGroups!) {
      final now = DateTime.now();
      final s = timeGroup.startTime;
      final e = timeGroup.endTime;

      await MySqfLite().insert("time_groups", {
        "day": timeGroup.day,
        "start_time": DateTime(
          now.year,
          now.month,
          now.day,
          s.hour,
          s.minute,
        ).toString(),
        "end_time": DateTime(
          now.year,
          now.month,
          now.day,
          e.hour,
          e.minute,
        ).toString(),
        "group_id": id,
      });
    }

    init();
    notifyListeners();
  }

  void editGroup(GroupsEntity group) async {
    await MySqfLite().update(
      "groups",
      {"price": group.price, "grade": group.grade},
      whereClause: "id = ?",
      whereArgs: [group.id],
    );

    final now = DateTime.now();

    final List<int> timeGroupsIds = group.timeGroups!
        .where((t) => t.id != null)
        .map((t) => t.id!)
        .toList();

    if (timeGroupsIds.isEmpty) {
      await MySqfLite().delete(
        "time_groups",
        whereClause: "group_id = ?",
        whereArgs: [group.id],
      );
    } else {
      String placeholders = timeGroupsIds.map((_) => "?").join(", ");
      await MySqfLite().delete(
        "time_groups",
        whereClause: "group_id = ? AND id NOT IN ($placeholders)",
        whereArgs: [group.id, ...timeGroupsIds],
      );
    }

    for (var timeGroup in group.timeGroups!) {
      final s = timeGroup.startTime;
      final e = timeGroup.endTime;

      final data = {
        "day": timeGroup.day,
        "start_time": DateTime(
          now.year,
          now.month,
          now.day,
          s.hour,
          s.minute,
        ).toIso8601String(),
        "end_time": DateTime(
          now.year,
          now.month,
          now.day,
          e.hour,
          e.minute,
        ).toIso8601String(),
        "group_id": group.id,
      };

      if (timeGroup.id == null || timeGroup.id == 0) {
        await MySqfLite().insert("time_groups", data);
        print("تم إضافة موعد جديد");
      } else {
        await MySqfLite().update(
          "time_groups",
          data,
          whereClause: "id = ?",
          whereArgs: [timeGroup.id],
        );
        print("تم تعديل موعد");
      }
    }

    init();
    notifyListeners();
  }

  // Students
  void addStudent(StudentsEntity student) async {
    await MySqfLite().insert("students", {
      "name": student.name,
      "phone": student.phone,
      "created_time": student.createdTime.toString(),
    });
    init();
    notifyListeners();
  }

  void editStudent(StudentsEntity student) async {
    await MySqfLite().update(
      "students",
      {
        "name": student.name,
        "phone": student.phone,
        "group_id": student.groupID,
      },
      whereClause: "id = ?",
      whereArgs: [student.id],
    );
    init();
    notifyListeners();
  }

  // Expenses
  void addExpense(ExpensesEntity expense) async {
    await MySqfLite().insert("expenses", {
      "title": expense.title,
      "amount": expense.amount,
      "description": expense.note,
      "created_time": expense.createdTime.toString(),
    });
    init();
    notifyListeners();
  }

  // Attendances
  void addAttendance(AttendancesEntity attendance) async {
    await MySqfLite().insert("attendances", {
      "student_id": attendance.studentID,
      "group_id": attendance.groupID,
      "grade": attendance.grade,
      "status": attendance.status,
      "created_time": attendance.createdTime.toString(),
    });
    init();
    notifyListeners();
  }

  void deleteAttendance(int id) async {
    await MySqfLite().delete(
      "attendances",
      whereClause: "id = ?",
      whereArgs: [id],
    );
    init();
    notifyListeners();
  }

  static final List days = [
    "السبت",
    "الاحد",
    "الاثنين",
    "الثلاثاء",
    "الاربعاء",
    "الخميس",
    "الجمعة",
  ];
  static final List times = ["صباحاً", "مساءً"];
}
