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
  int id;
  String day1;
  String day2;
  double from;
  double to;
  double price;
  double grade;

  List<StudentsEntity>? students;

  GroupsEntity({
    required this.id,
    required this.day1,
    required this.day2,
    required this.from,
    required this.to,
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

class AnalysisEntity {
  String title;
  int value;

  AnalysisEntity({required this.title, required this.value});
}
