import 'package:abo_sadah/core/Theme/Colors.dart';
import 'package:abo_sadah/core/widgets/BottomSheet.dart';
import 'package:abo_sadah/core/widgets/Button.dart';
import 'package:abo_sadah/core/widgets/Input.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class EditStud extends StatelessWidget {
  EditStud({super.key, required this.studentData});

  final Map studentData;

  final Map<String, TextEditingController> c = {
    "img": TextEditingController(),
    "name": TextEditingController(),
    "phone": TextEditingController(),
    "group": TextEditingController(),
  };

  @override
  Widget build(BuildContext context) {
    return MyBottomsheet(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(studentData["img"]),
                radius: 80,
              ),
              GestureDetector(
                onTap: () {
                  print("اختيار صورة");
                },
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: ThemeColors.background,
                  child: Icon(
                    LucideIcons.camera,
                    color: ThemeColors.primary,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 10),
          Input(
            title: "الاسم",
            value: studentData["name"],
            controller: c["name"]!,
          ),
          Input(
            title: "الهاتف",
            value: studentData["phone"],
            controller: c["phone"]!,
          ),
          Input(
            title: "المجموعة",
            value: studentData["group"],
            controller: c["group"]!,
          ),
          SizedBox(height: 10),
          Button(
            title: "حفظ",
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
