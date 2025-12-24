import 'package:day_night_time_picker/lib/state/time.dart';

class GroupsEntity {
  int? id;
  double price;
  double grade;

  List<TimeGroupsEntity>? timeGroups;
  List<StudentsEntity>? students;

  factory GroupsEntity.fromMap(Map<String, dynamic> map) {
    return GroupsEntity(
      id: map['id'],
      price: (map['price'] as num).toDouble(),
      grade: (map['grade'] as num).toDouble(),
      timeGroups: (map['time_groups'] as List<dynamic>?)
          ?.map((e) => TimeGroupsEntity.fromMap(e))
          .toList(),
      students: (map['students'] as List<dynamic>?)
          ?.map((e) => StudentsEntity.fromMap(e))
          .toList(),
    );
  }

  GroupsEntity({
    this.id,
    required this.price,
    required this.grade,
    this.timeGroups,
    this.students,
  });

  @override
  String toString() {
    return "GroupsEntity(id: $id, price: $price, grade: $grade, timeGroups: $timeGroups, students: $students)";
  }
}

class TimeGroupsEntity {
  int? id;
  String day;
  Time startTime;
  Time endTime;
  int? groupID;

  factory TimeGroupsEntity.fromMap(Map<String, dynamic> map) {
    final s = DateTime.parse(map['start_time']);
    final e = DateTime.parse(map['end_time']);
    return TimeGroupsEntity(
      id: map['id'],
      day: map['day'],
      startTime: Time(hour: s.hour, minute: s.minute),
      endTime: Time(hour: e.hour, minute: e.minute),
      groupID: map['group_id'],
    );
  }

  TimeGroupsEntity({
    this.id,
    required this.day,
    required this.startTime,
    required this.endTime,
    this.groupID,
  });

  @override
  String toString() {
    return "TimeGroupsEntity(id: $id, day: $day, startTime: $startTime, endTime: $endTime, groupID: $groupID)";
  }
}

class StudentsEntity {
  int? id;
  String name;
  String phone;
  int? groupID;
  DateTime createdTime;

  GroupsEntity? groupData;

  factory StudentsEntity.fromMap(Map<String, dynamic> map) {
    return StudentsEntity(
      id: map['id'],
      name: map['name'],
      phone: map['phone'],
      groupID: map['group_id'],
      createdTime: DateTime.parse(map['created_time']),
      groupData: map['group_data'],
    );
  }

  StudentsEntity({
    this.id,
    required this.name,
    required this.phone,
    this.groupID,
    required this.createdTime,
    this.groupData,
  });

  @override
  String toString() {
    return "StudentsEntity(id: $id, name: $name, phone: $phone, groupID: $groupID, createdTime: $createdTime, groupData: $groupData)";
  }
}

class AttendancesEntity {
  int id;
  int studentID;
  int groupID;
  double? grade;
  int status;
  DateTime createdTime;

  factory AttendancesEntity.fromMap(Map<String, dynamic> map) {
    return AttendancesEntity(
      id: map['id'],
      studentID: map['student_id'],
      groupID: map['group_id'],
      grade: map['grade'],
      status: map['status'],
      createdTime: DateTime.parse(map['created_time']),
    );
  }

  AttendancesEntity({
    required this.id,
    required this.studentID,
    required this.groupID,
    this.grade,
    required this.status,
    required this.createdTime,
  });
}

class ExpensesEntity {
  int? id;
  String title;
  String? note;
  double amount;
  DateTime createdTime;

  factory ExpensesEntity.fromMap(Map<String, dynamic> map) {
    return ExpensesEntity(
      id: map['id'],
      title: map['title'],
      note: map['description'],
      amount: (map['amount'] as num).toDouble(),
      createdTime: DateTime.parse(map['created_time']),
    );
  }

  ExpensesEntity({
    this.id,
    required this.title,
    this.note,
    required this.amount,
    required this.createdTime,
  });

  @override
  String toString() {
    return "ExpensesEntity(id: $id, title: $title, note: $note, amount: $amount, createdTime: $createdTime)";
  }
}

class AnalysisEntity {
  String title;
  num value;

  AnalysisEntity({required this.title, required this.value});
}
