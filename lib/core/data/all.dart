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
    timeGroups = timeGroupsData.map(TimeGroupsEntity.fromMap).toList();

    final studentsData = await MySqfLite().query('students');
    students = studentsData.map(StudentsEntity.fromMap).toList();

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
    groups.add(GroupsEntity(id: id, price: group.price, grade: group.grade));
    notifyListeners();
  }

  List<TimeGroupsEntity> timeGroups = [];
  List<StudentsEntity> students = [];
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
