import 'package:abo_sadah/core/Theme/colors.dart';
import 'package:abo_sadah/core/data/all.dart';
import 'package:abo_sadah/core/data/typs.dart';
import 'package:abo_sadah/core/widgets/custom_grid.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

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
                return Container(
                  decoration: BoxDecoration(
                    color: ThemeColors.forground,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding: EdgeInsets.all(5),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    leading: Icon(LucideIcons.user),
                    title: Text(student.name),
                    subtitle: Text(student.phone),
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
