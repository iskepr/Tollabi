import 'package:abo_sadah/core/widgets/BottomSheet.dart';
import 'package:abo_sadah/core/widgets/Button.dart';
import 'package:abo_sadah/core/widgets/Input.dart';
import 'package:flutter/material.dart';

class AddStud extends StatefulWidget {
  const AddStud({super.key});

  @override
  State<AddStud> createState() => _AddStudState();
}

class _AddStudState extends State<AddStud> {
  @override
  Widget build(BuildContext context) {
    return MyBottomsheet(
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
          Input(title: "اسم الطالب", controller: TextEditingController()),
          Input(title: "رقم الهاتف", controller: TextEditingController()),
          SizedBox(height: 20),
          Button(
            title: "إضافة",
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
