import 'package:abo_sadah/core/data/typs.dart';
import 'package:abo_sadah/core/data/sqflite/sql.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppData extends ChangeNotifier {
  AppData() {
    _init();
  }
  Future<void> _init() async {
    final prefs = await SharedPreferences.getInstance();
    isFirstTime = prefs.getBool('isFirstTime')!;

    final groupsData = await MySqfLite().query('groups');
    groups = groupsData.map(GroupsEntity.fromMap).toList();

    final timeGroupsData = await MySqfLite().query('time_groups');
    //  timeGroups = timeGroupsData.map(TimeGroupsEntity.fromMap).toList();

    final studentsData = await MySqfLite().query('students');
    students = studentsData.map(StudentsEntity.fromMap).toList();

    print(students);

    groups = groupsData.map((gMap) {
      final gId = gMap['id'];
      final groupStudents = studentsData
          .where((s) => s['group_id'] == gId)
          .toList();
      final groupTimes = timeGroupsData
          .where((t) => t['group_id'] == gId)
          .toList();

      return GroupsEntity.fromMap({
        ...gMap,
        'students': groupStudents,
        'time_groups': groupTimes,
      });
    }).toList();

    final attendancesData = await MySqfLite().query('attendances');
    attendances = attendancesData.map(AttendancesEntity.fromMap).toList();

    final expensesData = await MySqfLite().query('expenses');
    expenses = expensesData.map(ExpensesEntity.fromMap).toList();

    notifyListeners();
  }

  bool isFirstTime = false;

  List<GroupsEntity> groups = [];
  void addGroup(GroupsEntity group) async {
    int id = await MySqfLite().insert('groups', {
      'price': group.price,
      'grade': group.grade,
    });

    for (var timeGroup in group.timeGroups!) {
      final now = DateTime.now();
      final s = timeGroup.startTime;
      final e = timeGroup.endTime;

      await MySqfLite().insert('time_groups', {
        'day': timeGroup.day,
        'start_time': DateTime(
          now.year,
          now.month,
          now.day,
          s.hour,
          s.minute,
          s.second,
        ).toString(),
        'end_time': DateTime(
          now.year,
          now.month,
          now.day,
          e.hour,
          e.minute,
          e.second,
        ).toString(),
        'group_id': id,
      });
    }

    _init();
    notifyListeners();
  }

  List<StudentsEntity> students = [];
  void addStudent(StudentsEntity student) async {
    await MySqfLite().insert('students', {
      'name': student.name,
      "phone": student.phone,
      "created_time": student.createdTime.toString(),
    });
    _init();
    notifyListeners();
  }

  void editStudent(StudentsEntity student) async {
    await MySqfLite().update(
      'students',
      {
        'name': student.name,
        "phone": student.phone,
        'group_id': student.groupID,
      },
      whereClause: 'id = ?',
      whereArgs: [student.id],
    );
    _init();
    notifyListeners();
  }

  List<AttendancesEntity> attendances = [];
  List<ExpensesEntity> expenses = [];

  List<AnalysisEntity> analysisData = [
    AnalysisEntity(title: "إيرادات الشهر الماضي", value: 200),
    AnalysisEntity(title: "إيرادات الشهر الحالي", value: 1220),
    AnalysisEntity(title: "إيرادات اليوم", value: 433),

    AnalysisEntity(title: "مصروفات الشهر الماضي", value: 20),
    AnalysisEntity(title: "مصروفات الشهر الحالي", value: 20),
    AnalysisEntity(title: "مصروفات اليوم", value: 20),

    AnalysisEntity(title: "صافي الشهر الماضي", value: 20),
    AnalysisEntity(title: "صافي الشهر الحالي", value: 20),
    AnalysisEntity(title: "صافي اليوم", value: 20),

    AnalysisEntity(title: "المجموعات", value: 20),
    AnalysisEntity(title: "المشرفين", value: 20),
    AnalysisEntity(title: "الطلاب", value: 20),
  ];

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
