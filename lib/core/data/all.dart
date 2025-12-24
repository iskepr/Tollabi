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

  AppData() {
    _init();
  }

  Future<void> _init() async {
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

    // Mapping
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

    _calculateAnalysis();
    notifyListeners();
  }

  void _calculateAnalysis() {
    final now = DateTime.now();

    double expMonth = _sumExpenses(
      expenses,
      (e) => e.createdTime.month == now.month && e.createdTime.year == now.year,
    );
    double expLastMonth = _sumExpenses(
      expenses,
      (e) =>
          e.createdTime.month == now.month - 1 &&
          e.createdTime.year == now.year,
    );
    double expToday = _sumExpenses(
      expenses,
      (e) => e.createdTime.day == now.day && e.createdTime.month == now.month,
    );

    analysisData = [
      AnalysisEntity(title: "الطلاب", value: students.length),
      AnalysisEntity(title: "المجموعات", value: groups.length),
      AnalysisEntity(title: "المشرفين", value: 0),

      AnalysisEntity(title: "إيرادات الشهر الحالي", value: 0),
      AnalysisEntity(title: "إيرادات اليوم", value: 0),
      AnalysisEntity(title: "إيرادات الشهر الماضي", value: 0),

      AnalysisEntity(title: "مصروفات الشهر الحالي", value: expMonth),
      AnalysisEntity(title: "مصروفات اليوم", value: expToday),
      AnalysisEntity(title: "مصروفات الشهر الماضي", value: expLastMonth),

      AnalysisEntity(title: "صافي الشهر الحالي", value: 0),
      AnalysisEntity(title: "صافي اليوم", value: 0),
      AnalysisEntity(title: "صافي الشهر الماضي", value: 0),
    ];
  }

  double _sumExpenses(
    List<ExpensesEntity> list,
    bool Function(ExpensesEntity) test,
  ) {
    return list.where(test).fold(0.0, (sum, e) => sum + e.amount);
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
          s.second,
        ).toString(),
        "end_time": DateTime(
          now.year,
          now.month,
          now.day,
          e.hour,
          e.minute,
          e.second,
        ).toString(),
        "group_id": id,
      });
    }

    _init();
    notifyListeners();
  }

  void editGroup(GroupsEntity group) async {
    await MySqfLite().update(
      "groups",
      {"price": group.price, "grade": group.grade},
      whereClause: "id = ?",
      whereArgs: [group.id],
    );
    _init();
    notifyListeners();
  }

  // Students
  void addStudent(StudentsEntity student) async {
    await MySqfLite().insert("students", {
      "name": student.name,
      "phone": student.phone,
      "created_time": student.createdTime.toString(),
    });
    _init();
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
    _init();
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
    _init();
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
