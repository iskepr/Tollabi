import 'package:abo_sadah/core/data/all.dart';
import 'package:abo_sadah/core/data/typs.dart';
import 'package:abo_sadah/core/widgets/custom_bottom_sheet.dart';
import 'package:abo_sadah/core/widgets/custom_button.dart';
import 'package:abo_sadah/core/widgets/Inputs/Input.dart';
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
          Input(title: "رقم الهاتف", controller: c["phone"]!),
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
            },
          ),
        ],
      ),
    );
  }
}
