import 'package:abo_sadah/core/widgets/BottomSheet.dart';
import 'package:abo_sadah/core/widgets/Button.dart';
import 'package:abo_sadah/core/widgets/Inputs/Input.dart';
import 'package:flutter/material.dart';

class AddGroup extends StatefulWidget {
  const AddGroup({super.key});

  @override
  State<AddGroup> createState() => _AddGroupState();
}

class _AddGroupState extends State<AddGroup> {
  final List days = [
    "اختر اليوم",
    "السبت",
    "الاحد",
    "الاثنين",
    "الثلاثاء",
    "الاربعاء",
    "الخميس",
    "الجمعة",
  ];
  _fildBuilder(String title, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        child,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MyBottomsheet(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(15),
            child: Text(
              "إضافة مجموعة جديدة",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          _fildBuilder(
            "رقم المجموعة",
            Input(title: "رقم المجموعة", controller: TextEditingController()),
          ),

          _fildBuilder(
            "ايام المجموعة",
            Row(
              children: [
                Expanded(
                  child: Input(
                    title: "الفترة",
                    type: "select",
                    value: days.first,
                    items: days,
                    onChanged: (value) {},
                    controller: TextEditingController(),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Input(
                    title: "الفترة",
                    type: "select",
                    value: days.first,
                    items: days,
                    onChanged: (value) {},
                    controller: TextEditingController(),
                  ),
                ),
              ],
            ),
          ),

          _fildBuilder(
            "مواعيد المجموعة",
            Row(
              children: [
                Expanded(
                  child: Input(
                    title: "من",
                    controller: TextEditingController(),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Input(
                    title: "الى",
                    controller: TextEditingController(),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Input(
                    title: "الفترة",
                    type: "select",
                    value: "صباحاً",
                    items: ["صباحاً", "مساءً"],
                    onChanged: (value) {},
                    controller: TextEditingController(),
                  ),
                ),
              ],
            ),
          ),

          _fildBuilder(
            "سعر الحصة",
            Input(title: "سعر الحصة", controller: TextEditingController()),
          ),
          _fildBuilder(
            "درجة الحصة",
            Input(title: "درجة الحصة", controller: TextEditingController()),
          ),

          const SizedBox(height: 20),
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
