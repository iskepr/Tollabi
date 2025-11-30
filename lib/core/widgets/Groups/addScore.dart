import 'package:abo_sadah/core/Data/all.dart';
import 'package:abo_sadah/core/Theme/Colors.dart';
import 'package:abo_sadah/core/Theme/TextStyles.dart';
import 'package:abo_sadah/core/widgets/BottomSheet.dart';
import 'package:abo_sadah/core/widgets/Button.dart';
import 'package:abo_sadah/core/widgets/Inputs/Input.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class AddScore extends StatelessWidget {
  const AddScore({super.key, required this.studentData});

  final Map studentData;
  String get group => AppData.groups.firstWhere(
    (group) => studentData["groupID"] == group["id"],
  )["name"];

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
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              "إضافة درجة التاسك للطالب",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: ThemeColors.forground),
              borderRadius: BorderRadius.circular(24),
            ),
            child: ListTile(
              leading: Icon(LucideIcons.user),
              title: Text(studentData["name"]),
              subtitle: Text(studentData["phone"]),
              trailing: Text(group.toString(), style: TextStyles.trailing),
            ),
          ),
          _fildBuilder(
            "درجة الطالب (10 درجات)",
            Input(title: "00", controller: TextEditingController()),
          ),
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
