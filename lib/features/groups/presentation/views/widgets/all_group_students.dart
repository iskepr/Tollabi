import 'package:tollabi/core/Theme/colors.dart';
import 'package:tollabi/core/data/all.dart';
import 'package:tollabi/core/data/typs.dart';
import 'package:tollabi/core/widgets/custom_grid.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:tollabi/features/students/presentation/views/student_acount_view.dart';

class AllGroupStudents extends StatefulWidget {
  const AllGroupStudents({super.key, required this.group});

  final GroupsEntity group;

  @override
  State<AllGroupStudents> createState() => _AllGroupStudentsState();
}

class _AllGroupStudentsState extends State<AllGroupStudents> {
  List<StudentsEntity> students = [];

  @override
  void initState() {
    super.initState();
    final data = Provider.of<AppData>(context, listen: false);
    students = data.students
        .where((student) => student.groupID == widget.group.id)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "جميع طلاب المجموعة:",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Consumer<AppData>(
          builder: (context, data, child) {
            students = (data.students)
                .where((e) => e.groupID == widget.group.id)
                .toList();
            return CustomGrid(
              count: students.length,
              emptyText: "لا يوجد طلاب",
              child: (context, index) {
                final student = students[index];
                return GestureDetector(
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
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      leading: Icon(LucideIcons.user),
                      title: Text(student.name),
                      subtitle: Text(student.phone),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
