import 'package:abo_sadah/core/Data/all.dart';
import 'package:abo_sadah/core/Theme/Colors.dart';
import 'package:abo_sadah/core/widgets/BottomSheet.dart';
import 'package:abo_sadah/core/widgets/Button.dart';
import 'package:abo_sadah/core/widgets/Inputs/Input.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class EditStud extends StatelessWidget {
  EditStud({super.key, required this.studentData});

  final Map studentData;
  final List<Map<String, dynamic>> groups = AppData.groups;

  final Map<String, TextEditingController> c = {
    "img": TextEditingController(),
    "name": TextEditingController(),
    "phone": TextEditingController(),
    "groupID": TextEditingController(),
  };

  @override
  Widget build(BuildContext context) {
    return MyBottomsheet(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Icon(LucideIcons.user),
              GestureDetector(
                onTap: () {
                  print("اختيار صورة");
                  print(groups.map((group) => group["name"]).toList());
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
            controller: c["groupID"]!,
            type: "select",
            value: groups.firstWhere(
              (group) => group["id"] == studentData["groupID"],
            )["name"],
            items: groups.map((group) => group["name"]).toList(),
            onChanged: (value) {
              c["groupID"]!.text = groups
                  .firstWhere((group) => group["name"] == value)["id"]
                  .toString();
            },
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
