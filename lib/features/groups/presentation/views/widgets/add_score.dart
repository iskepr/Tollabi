import 'package:tollabi/core/data/all.dart';
import 'package:tollabi/core/data/typs.dart';
import 'package:tollabi/core/Theme/colors.dart';
import 'package:tollabi/core/Theme/text_styles.dart';
import 'package:tollabi/core/widgets/custom_bottom_sheet.dart';
import 'package:tollabi/core/widgets/inputs/custom_button.dart';
import 'package:tollabi/core/widgets/inputs/input.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

class AddScore extends StatelessWidget {
  const AddScore({super.key, required this.studentData});

  final StudentsEntity studentData;

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
    return CustomBottomSheet(
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
            child: Consumer<AppData>(
              builder: (context, data, child) => ListTile(
                leading: Icon(LucideIcons.user),
                title: Text(studentData.name),
                subtitle: Text(studentData.phone),
                trailing: Text(
                  data.groups
                      .firstWhere((group) => studentData.groupID == group.id)
                      .id
                      .toString(),
                  style: TextStyles.trailing,
                ),
              ),
            ),
          ),
          _fildBuilder(
            "درجة الطالب (10 درجات)",
            Input(title: "00", controller: TextEditingController()),
          ),
          const SizedBox(height: 20),
          CustomButton(
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
