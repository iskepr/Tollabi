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
      timeGroups: (map['time_groups'] as List)
          .map((e) => TimeGroupsEntity.fromMap(e))
          .toList(),
      students: (map['students'] as List)
          .map((e) => StudentsEntity.fromMap(e))
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
}

class TimeGroupsEntity {
  int id;
  String day;
  String startTime;
  String endTime;
  int? groupID;

  factory TimeGroupsEntity.fromMap(Map<String, dynamic> map) {
    return TimeGroupsEntity(
      id: map['id'],
      day: map['day'],
      startTime: map['start_time'],
      endTime: map['end_time'],
      groupID: map['group_id'],
    );
  }

  TimeGroupsEntity({
    required this.id,
    required this.day,
    required this.startTime,
    required this.endTime,
    this.groupID,
  });
}

class StudentsEntity {
  int id;
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
    required this.id,
    required this.name,
    required this.phone,
    this.groupID,
    required this.createdTime,
    this.groupData,
  });
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
  int id;
  String title;
  String description;
  double amount;
  DateTime createdTime;

  factory ExpensesEntity.fromMap(Map<String, dynamic> map) {
    return ExpensesEntity(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      amount: (map['amount'] as num).toDouble(),
      createdTime: DateTime.parse(map['created_time']),
    );
  }

  ExpensesEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.amount,
    required this.createdTime,
  });
}

class AnalysisEntity {
  String title;
  int value;

  AnalysisEntity({required this.title, required this.value});
}
