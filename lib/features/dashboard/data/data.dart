import 'package:tollabi/core/data/all.dart';
import 'package:tollabi/core/data/typs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

List<AnalysisEntity> calculateAnalysis(BuildContext context) {
  final data = Provider.of<AppData>(context, listen: false);
  final now = DateTime.now();

  double expMonth = _sumExpenses(
    data.expenses,
    (e) => e.createdTime.month == now.month && e.createdTime.year == now.year,
  );
  double expLastMonth = _sumExpenses(
    data.expenses,
    (e) =>
        e.createdTime.month == now.month - 1 && e.createdTime.year == now.year,
  );
  double expToday = _sumExpenses(
    data.expenses,
    (e) => e.createdTime.day == now.day && e.createdTime.month == now.month,
  );

  return [
    AnalysisEntity(title: "الطلاب", value: data.students.length),
    AnalysisEntity(title: "المجموعات", value: data.groups.length),
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
