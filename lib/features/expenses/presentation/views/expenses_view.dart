import 'package:abo_sadah/core/Theme/colors.dart';
import 'package:abo_sadah/core/data/all.dart';
import 'package:abo_sadah/core/utils/format.dart';
import 'package:abo_sadah/core/widgets/inputs/custom_button.dart';
import 'package:abo_sadah/features/expenses/presentation/views/widgets/add_expenses.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ExpensesView extends StatelessWidget {
  const ExpensesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("المصروفات", style: TextStyle(fontSize: 20)),
            CustomButton(
              title: "+  إضافة مصروف",
              fontSize: 14,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              radius: 16,
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => AddExpenses(),
                );
              },
            ),
          ],
        ),

        Consumer<AppData>(
          builder: (context, data, child) {
            return Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    ThemeColors.primary.withAlpha(200),
                    ThemeColors.primary,
                  ],
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              child: ListTile(
                title: Text(
                  "مصروفات الشهر الحالي",
                  style: TextStyle(color: ThemeColors.background),
                ),
                subtitle: Text(
                  DateFormat.MMMM('ar').format(DateTime.now()),
                  style: TextStyle(color: ThemeColors.background),
                ),
                trailing: Text(
                  "${formatDouble(data.expenses.fold(0.0, (previousValue, element) => previousValue + element.amount))} جنية",
                  style: TextStyle(color: ThemeColors.background, fontSize: 20),
                ),
              ),
            );
          },
        ),

        Consumer<AppData>(
          builder: (context, data, child) {
            if (data.expenses.isEmpty) {
              return Text("لا يوجد مصروفات");
            }
            return Column(
              spacing: 10,
              children: List.generate(data.expenses.length, (index) {
                final expense = data.expenses[index];
                return Container(
                  decoration: BoxDecoration(
                    color: ThemeColors.forground,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    title: Text(expense.title),
                    subtitle: Text(
                      (expense.note ?? '').isNotEmpty
                          ? "${expense.note} - ${formatTime(expense.createdTime).formatH}"
                          : formatTime(expense.createdTime).formatH,
                    ),
                    trailing: Text(
                      "${formatDouble(expense.amount)} جنية",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                );
              }),
            );
          },
        ),
      ],
    );
  }
}
