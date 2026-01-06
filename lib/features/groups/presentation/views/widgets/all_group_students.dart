import 'package:abo_sadah/core/Theme/Colors.dart';
import 'package:abo_sadah/core/data/all.dart';
import 'package:abo_sadah/core/data/typs.dart';
import 'package:abo_sadah/core/widgets/Button.dart';
import 'package:abo_sadah/core/widgets/Inputs/Input.dart';
import 'package:abo_sadah/features/groups/presentation/views/widgets/add_score.dart';
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
  TextEditingController search = TextEditingController();
  List<StudentsEntity> allStudents = [];
  List<StudentsEntity> students = [];

  @override
  void initState() {
    super.initState();
    final data = Provider.of<AppData>(context, listen: false);
    allStudents = data.students;
    students = allStudents
        .where((student) => student.groupID == widget.group.id)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        Input(
          title: "ابحث عن طالب",
          style: "border",
          prefixIcon: Icons.search,
          controller: search,
          onChanged: (value) => setState(() {
            students = allStudents
                .where((stud) => stud.name.contains(value.toString()))
                .toList();
          }),
        ),
        Consumer<AppData>(
          builder: (context, data, child) {
            students = (data.students)
                .where((e) => e.groupID == widget.group.id)
                .toList();
            return Column(
              spacing: 5,
              children: List.generate(students.length, (index) {
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
                    subtitle: Text(student.name),
                    trailing: Button(
                      title: "إعطاء درجة التاسك",
                      fontSize: 10,
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) =>
                              AddScore(studentData: students[index]),
                        );
                      },
                    ),
                  ),
                );
              }),
            );
          },
        ),
      ],
    );
  }
}
