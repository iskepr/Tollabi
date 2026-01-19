import 'package:tollabi/core/data/all.dart';
import 'package:tollabi/core/data/typs.dart';
import 'package:tollabi/core/functions/show_message.dart';
import 'package:tollabi/core/widgets/custom_bottom_sheet.dart';
import 'package:tollabi/core/widgets/inputs/custom_button.dart';
import 'package:tollabi/core/widgets/inputs/input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddStud extends StatefulWidget {
  const AddStud({super.key});

  @override
  State<AddStud> createState() => _AddStudState();
}

class _AddStudState extends State<AddStud> {
  final Map<String, TextEditingController> c = {
    "name": TextEditingController(),
    "phone": TextEditingController(),
  };
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<AppData>(context, listen: false);

    return CustomBottomSheet(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              "إضافة طالب جديد",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Input(title: "اسم الطالب", controller: c["name"]!),
          Input(title: "رقم الهاتف", type: "number", controller: c["phone"]!),
          const SizedBox(height: 20),
          CustomButton(
            title: "إضافة",
            onTap: () {
              data.addStudent(
                StudentsEntity(
                  name: c["name"]!.text,
                  phone: c["phone"]!.text,
                  createdTime: DateTime.now(),
                ),
              );
              Navigator.pop(context);
              showMessage(context, "تم اضافة الطالب بنجاح");
            },
          ),
        ],
      ),
    );
  }
}
