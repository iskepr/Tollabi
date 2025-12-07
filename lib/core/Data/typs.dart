class StudentsEntity {
  int id;
  String name;
  String phone;
  int? groupId;

  StudentsEntity({
    required this.id,
    required this.name,
    required this.phone,
    this.groupId,
  });
}

class GroupsEntity {
  int? id;
  String day1;
  String day2;
  double startTime;
  double endTime;
  bool isAM;
  double price;
  double grade;

  List<StudentsEntity>? students;

  GroupsEntity({
    this.id,
    required this.day1,
    required this.day2,
    required this.startTime,
    required this.endTime,
    required this.isAM,
    required this.price,
    required this.grade,
    this.students,
  });
}

class TasksEntity {
  int id;
  String title;
  int score;
  DateTime time;

  TasksEntity({
    required this.id,
    required this.title,
    required this.score,
    required this.time,
  });
}

class GradesEntity {
  int id;
  int taskID;
  int score;
  int groupID;

  GradesEntity({
    required this.id,
    required this.taskID,
    required this.score,
    required this.groupID,
  });
}

class AnalysisEntity {
  String title;
  int value;

  AnalysisEntity({required this.title, required this.value});
}
