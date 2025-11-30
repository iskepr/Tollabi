abstract class AppData {
  static final List<Map<String, dynamic>> students = [
    {"id": 1, "name": "احمد علي خالد", "phone": "+20 0109876543", "groupID": 1},
    {
      "id": 2,
      "name": "محمد محمد محمد",
      "phone": "+20 0109876543",
      "groupID": 1,
    },
    {"id": 3, "name": "احمد علي خالد", "phone": "+20 0109876543", "groupID": 1},
    {"id": 4, "name": "احمد علي خالد", "phone": "+20 0109876543", "groupID": 2},
  ];

  static final List<Map<String, dynamic>> groups = [
    {"id": 1, "name": "مجموعة 1", "time": "05:07", "days": "السبت - الثلاثاء"},
    {"id": 2, "name": "مجموعة 2", "time": "05:07", "days": "السبت - الثلاثاء"},
    {"id": 3, "name": "مجموعة 3", "time": "05:07", "days": "السبت - الثلاثاء"},
    {"id": 4, "name": "مجموعة 4", "time": "05:07", "days": "السبت - الثلاثاء"},
  ];

  static final List<Map<String, dynamic>> tasks = [
    {"id": 1, "title": "Task 1", "score": 10, "time": "17/11/2025"},
    {"id": 2, "title": "Task 1", "score": 10, "time": "17/11/2025"},
    {"id": 3, "title": "Task 1", "score": 10, "time": "17/11/2025"},
    {"id": 4, "title": "Task 1", "score": 10, "time": "17/11/2025"},
    {"id": 5, "title": "Task 1", "score": 10, "time": "17/11/2025"},
    {"id": 6, "title": "Task 1", "score": 10, "time": "17/11/2025"},
  ];

  static final List<Map<String, dynamic>> analysisData = [
    {"title": "إيرادات الشهر الماضي", "value": "20"},
    {"title": "إيرادات الشهر الحالي", "value": "50"},
    {"title": "إيرادات اليوم", "value": "30"},

    {"title": "مصروفات الشهر الماضي", "value": "30"},
    {"title": "مصروفات الشهر الحالي", "value": "30"},
    {"title": "مصروفات اليوم", "value": "30"},

    {"title": "صافي الشهر الماضي", "value": "30"},
    {"title": "صافي الشهر الحالي", "value": "30"},
    {"title": "صافي اليوم", "value": "30"},

    {"title": "المجموعات", "value": "30"},
    {"title": "المشرفين", "value": "30"},
    {"title": "الطلاب", "value": "30"},
  ];
}
