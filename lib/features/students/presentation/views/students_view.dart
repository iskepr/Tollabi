import 'package:abo_sadah/core/data/all.dart';
import 'package:abo_sadah/core/data/typs.dart';
import 'package:abo_sadah/core/Theme/colors.dart';
import 'package:abo_sadah/core/widgets/inputs/custom_button.dart';
import 'package:abo_sadah/core/widgets/custom_grid.dart';
import 'package:abo_sadah/core/widgets/inputs/input.dart';
import 'package:abo_sadah/features/students/presentation/views/widgets/add_student.dart';
import 'package:abo_sadah/features/students/presentation/views/student_acount_view.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

class StudentsView extends StatelessWidget {
  StudentsView({super.key});

  List<StudentsEntity> students = [];
  TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<AppData>(
      builder: (context, data, child) {
        students = data.students;
        return Column(
          spacing: 10,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("كل الطلاب", style: TextStyle(fontSize: 20)),
                CustomButton(
                  title: "+ إضافة طالب",
                  fontSize: 14,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  radius: 16,
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => AddStud(),
                    );
                  },
                ),
              ],
            ),
            Input(
              title: "ابحث عن طالب",
              style: "border",
              prefixIcon: Icons.search,
              controller: search,
              onChanged: (value) => students = data.students
                  .where((stud) => stud.name.contains(value.toString()))
                  .toList(),
            ),
            CustomGrid(
              count: students.length,
              emptyText: "لا يوجد طلاب",
              child: (BuildContext context, int index) => GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          StudentAcountView(studentID: students[index].id!),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: ThemeColors.forground,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      students[index].name,
                      style: TextStyle(fontSize: 14),
                    ),
                    subtitle: Text(
                      students[index].phone,
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 14),
                    ),
                    leading: Icon(LucideIcons.user),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
