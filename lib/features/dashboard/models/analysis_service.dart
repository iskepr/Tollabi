import 'package:abo_sadah/core/data/typs.dart';

class AnalysisService {
  static List<AnalysisEntity> calculate(
    List<StudentsEntity> students,
    List<GroupsEntity> groups,
    List<ExpensesEntity> expenses,
    List<AttendancesEntity> attendances,
  ) {
    final now = DateTime.now();
    // بنحسب تاريخ الشهر اللي فات
    // لو احنا في شهر 1 سنة 2026، ده هيديك شهر 12 سنة 2025
    final lastMonthDate = DateTime(now.year, now.month - 1);

    // المصاريف
    double expMonth = _sumExpenses(
      expenses,
      (e) => e.createdTime.month == now.month && e.createdTime.year == now.year,
    );
    double expToday = _sumExpenses(
      expenses,
      (e) =>
          e.createdTime.day == now.day &&
          e.createdTime.month == now.month &&
          e.createdTime.year == now.year, // ضفت السنة هنا عشان الدقة
    );
    double expLastMonth = _sumExpenses(
      expenses,
      (e) =>
          e.createdTime.month == lastMonthDate.month &&
          e.createdTime.year == lastMonthDate.year,
    );

    // الإيرادات
    double incMonth = _sumIncome(
      attendances,
      groups,
      (a) => a.createdTime.month == now.month && a.createdTime.year == now.year,
    );
    double incToday = _sumIncome(
      attendances,
      groups,
      (a) =>
          a.createdTime.day == now.day &&
          a.createdTime.month == now.month &&
          a.createdTime.year == now.year,
    );
    double incLastMonth = _sumIncome(
      attendances,
      groups,
      (a) =>
          a.createdTime.month == lastMonthDate.month &&
          a.createdTime.year == lastMonthDate.year,
    );

    return [
      AnalysisEntity(title: "الطلاب", value: students.length),
      AnalysisEntity(title: "المجموعات", value: groups.length),
      AnalysisEntity(title: "المشرفين", value: 0),
      AnalysisEntity(title: "صافي الشهر الحالي", value: incMonth - expMonth),
      AnalysisEntity(title: "صافي اليوم", value: incToday - expToday),
      AnalysisEntity(
        title: "صافي الشهر الماضي",
        value: incLastMonth - expLastMonth,
      ),
      AnalysisEntity(title: "إيرادات الشهر الحالي", value: incMonth),
      AnalysisEntity(title: "إيرادات اليوم", value: incToday),
      AnalysisEntity(title: "إيرادات الشهر الماضي", value: incLastMonth),
      AnalysisEntity(title: "مصروفات الشهر الحالي", value: expMonth),
      AnalysisEntity(title: "مصروفات اليوم", value: expToday),
      AnalysisEntity(title: "مصروفات الشهر الماضي", value: expLastMonth),
    ];
  }

  static double _sumExpenses(
    List<ExpensesEntity> list,
    bool Function(ExpensesEntity) test,
  ) {
    return list.where(test).fold(0.0, (sum, e) => sum + e.amount);
  }

  static double _sumIncome(
    List<AttendancesEntity> attendanceList,
    List<GroupsEntity> groupsList,
    bool Function(AttendancesEntity) test,
  ) {
    double total = 0.0;
    final filteredAttendance = attendanceList.where(test);
    for (var attendance in filteredAttendance) {
      try {
        total += attendance.price;
      } catch (e) {
        continue;
      }
    }
    return total;
  }
}
