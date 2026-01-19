import 'package:tollabi/core/data/all.dart';
import 'package:tollabi/core/data/typs.dart';
import 'package:tollabi/core/functions/show_message.dart';
import 'package:tollabi/core/widgets/custom_bottom_sheet.dart';
import 'package:tollabi/core/widgets/inputs/custom_button.dart';
import 'package:tollabi/core/widgets/inputs/input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddExpenses extends StatefulWidget {
  const AddExpenses({super.key});

  @override
  State<AddExpenses> createState() => _AddExpensesState();
}

class _AddExpensesState extends State<AddExpenses> {
  final Map<String, TextEditingController> c = {
    "title": TextEditingController(),
    "amount": TextEditingController(),
    "note": TextEditingController(),
  };

  @override
  void dispose() {
    for (var controller in c.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<AppData>(context, listen: false);

    return CustomBottomSheet(
      child: Column(
        children: [
          const Text(
            "إضافة مجموعة جديدة",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          Input(title: "اسم المصروف", controller: c["title"]),
          Input(
            title: "المبلغ المصروف",
            controller: c["amount"],
            type: "number",
          ),
          Input(title: "ملاحظة (اختياري)", controller: c["note"]),

          const SizedBox(height: 20),
          CustomButton(
            title: "إضافة",
            onTap: () async {
              data.addExpense(
                ExpensesEntity(
                  title: c["title"]!.text,
                  amount: double.parse(c["amount"]!.text),
                  note: c["note"]!.text,
                  createdTime: DateTime.now(),
                ),
              );

              if (context.mounted) Navigator.pop(context);
              showMessage(context, "تم اضافة المصروف بنجاح");
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
