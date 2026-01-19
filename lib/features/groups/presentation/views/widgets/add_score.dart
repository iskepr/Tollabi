import 'package:tollabi/core/data/all.dart';
import 'package:tollabi/core/data/typs.dart';
import 'package:tollabi/core/Theme/colors.dart';
import 'package:tollabi/core/Theme/text_styles.dart';
import 'package:tollabi/core/functions/show_message.dart';
import 'package:tollabi/core/utils/format.dart';
import 'package:tollabi/core/widgets/custom_bottom_sheet.dart';
import 'package:tollabi/core/widgets/inputs/custom_button.dart';
import 'package:tollabi/core/widgets/inputs/input.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

class AddScore extends StatefulWidget {
  const AddScore({
    super.key,
    required this.studentData,
    required this.groupData,
  });

  final StudentsEntity studentData;
  final GroupsEntity groupData;

  @override
  State<AddScore> createState() => _AddScoreState();
}

class _AddScoreState extends State<AddScore> {
  final TextEditingController gradeController = TextEditingController();
  late AppData data;
  int? attendID;
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      data = Provider.of<AppData>(context, listen: false);
      final now = DateTime.now();

      try {
        final attend = data.attendances.firstWhere(
          (a) =>
              a.studentID == widget.studentData.id &&
              a.groupID == widget.groupData.id &&
              a.createdTime.year == now.year &&
              a.createdTime.month == now.month &&
              a.createdTime.day == now.day,
        );

        attendID = attend.id;
        gradeController.text = formatDouble(attend.grade);
      } catch (e) {
        attendID = null;
      }

      _isInitialized = true;
    }
  }

  _fildBuilder(String title, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        child,
      ],
    );
  }

  @override
  void dispose() {
    gradeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheet(
      child: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(15),
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
                leading: const Icon(LucideIcons.user),
                title: Text(widget.studentData.name),
                subtitle: Text(widget.studentData.phone),
                trailing: Text(
                  "مجموعة ${data.groups.firstWhere((group) => widget.studentData.groupID == group.id).id}",
                  style: TextStyles.trailing,
                ),
              ),
            ),
          ),
          _fildBuilder(
            "درجة الطالب (${formatDouble(widget.groupData.grade)} درجات)",
            Input(title: "الدرجة", controller: gradeController, type: "number"),
          ),
          const SizedBox(height: 20),
          CustomButton(
            title: "إضافة",
            onTap: () {
              if (attendID != null) {
                data.addGrade(
                  attendID!,
                  double.tryParse(gradeController.text) ?? 0.0,
                );
              }
              Navigator.pop(context);
              showMessage(context, "تم اضافة الدرجة بنجاح");
            },
          ),
        ],
      ),
    );
  }
}
