import 'package:abo_sadah/core/Data/all.dart';
import 'package:abo_sadah/core/widgets/BottomSheet.dart';
import 'package:abo_sadah/core/widgets/Button.dart';
import 'package:abo_sadah/core/widgets/Inputs/Input.dart';
import 'package:abo_sadah/core/widgets/Inputs/Select.dart';
import 'package:flutter/material.dart';

class EditGroup extends StatefulWidget {
  const EditGroup({super.key});

  @override
  State<EditGroup> createState() => _EditGroupState();
}

class _EditGroupState extends State<EditGroup> {
  final List days = AppData.days;

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
              "تعديل بيانات المجموعة",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
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
                    items: days
                        .map((day) => SelectItem(title: day, value: day))
                        .toList(),
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
                    items: days
                        .map((day) => SelectItem(title: day, value: day))
                        .toList(),
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
                    value: AppData.times.first,
                    items: AppData.times
                        .map((time) => SelectItem(title: time, value: time))
                        .toList(),
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
