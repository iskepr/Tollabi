import 'package:tollabi/core/data/all.dart';
import 'package:tollabi/core/data/typs.dart';
import 'package:tollabi/core/Theme/colors.dart';
import 'package:tollabi/core/widgets/inputs/custom_button.dart';
import 'package:tollabi/core/widgets/custom_grid.dart';
import 'package:tollabi/core/widgets/inputs/input.dart';
import 'package:tollabi/features/students/presentation/views/widgets/add_student.dart';
import 'package:tollabi/features/students/presentation/views/student_acount_view.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

class StudentsView extends StatefulWidget {
  const StudentsView({super.key});

  @override
  State<StudentsView> createState() => _StudentsViewState();
}

class _StudentsViewState extends State<StudentsView> {
  TextEditingController search = TextEditingController();
  List<StudentsEntity>? filteredStudents;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppData>(
      builder: (context, data, child) {
        final students = filteredStudents ?? data.students;

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
              onChanged: (value) {
                setState(() {
                  filteredStudents = data.students
                      .where(
                        (stud) => stud.name.toLowerCase().contains(
                          value.toString().toLowerCase(),
                        ),
                      )
                      .toList();
                });
              },
            ),
            CustomGrid(
              count: students.length,
              emptyText: "لا يوجد طلاب",
              child: (context, index) => GestureDetector(
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
                  decoration: BoxDecoration(
                    color: ThemeColors.forground,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: ListTile(
                    title: Text(students[index].name),
                    subtitle: Text(students[index].phone),
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
