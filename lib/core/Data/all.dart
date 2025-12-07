import 'package:abo_sadah/core/Data/typs.dart';
import 'package:abo_sadah/core/sqflite/mySql.dart';
import 'package:flutter/material.dart';

class AppData extends ChangeNotifier {
  AppData() {
    _init();
  }
  Future<void> _init() async {
    final data = await MySqfLite().query('groups');
    groups = data
        .map(
          (e) => GroupsEntity(
            id: e['id'],
            day1: e['day1'],
            day2: e['day2'],
            startTime: e['startTime'],
            endTime: e['endTime'],
            isAM: e['isAM'] == 1 ? true : false,
            price: e['price'],
            grade: e['grade'],
          ),
        )
        .toList();

    notifyListeners();
  }

  List<GroupsEntity> groups = [];
  void addGroup(GroupsEntity group) async {
    int id = await MySqfLite().insert('groups', {
      'day1': group.day1,
      'day2': group.day2,
      'startTime': group.startTime,
      'endTime': group.endTime,
      'isAM': group.isAM == times.first ? 1 : 0,
      'price': group.price,
      'grade': group.grade,
    });

    GroupsEntity newGroup = GroupsEntity(
      id: id,
      day1: group.day1,
      day2: group.day2,
      startTime: group.startTime,
      endTime: group.endTime,
      isAM: group.isAM,
      price: group.price,
      grade: group.grade,
    );

    groups.add(newGroup);

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

  List<StudentsEntity> students = [
    StudentsEntity(
      id: 1,
      name: "محمد احمد سامح",
      phone: "+20 0109876543",
      groupId: 1,
    ),
    StudentsEntity(
      id: 2,
      name: "يوسف علي سامح",
      phone: "+20 0109876543",
      groupId: 2,
    ),
    StudentsEntity(
      id: 3,
      name: "ابراهيم احمد مروان",
      phone: "+20 0109876543",
      groupId: 1,
    ),
    StudentsEntity(
      id: 4,
      name: "محمد يوسف سامح",
      phone: "+20 0109876543",
      groupId: 2,
    ),
    StudentsEntity(
      id: 5,
      name: "على احمد سامح",
      phone: "+20 0109876543",
      groupId: 3,
    ),
  ];

  List<TasksEntity> tasks = [
    TasksEntity(id: 1, title: "Task 1", score: 5, time: DateTime(2023, 1, 1)),
    TasksEntity(id: 2, title: "Task 1", score: 3, time: DateTime(2023, 1, 1)),
    TasksEntity(id: 3, title: "Task 1", score: 10, time: DateTime(2023, 1, 1)),
    TasksEntity(id: 4, title: "Task 1", score: 2, time: DateTime(2023, 1, 1)),
    TasksEntity(id: 5, title: "Task 1", score: 7, time: DateTime(2023, 1, 1)),
    TasksEntity(id: 6, title: "Task 1", score: 9, time: DateTime(2023, 1, 1)),
  ];

  static final List<AnalysisEntity> analysisData = [
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
}
