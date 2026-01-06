import 'package:abo_sadah/core/Theme/Colors.dart';
import 'package:abo_sadah/core/Theme/TextStyles.dart';
import 'package:abo_sadah/core/data/all.dart';
import 'package:abo_sadah/core/data/typs.dart';
import 'package:abo_sadah/core/widgets/Button.dart';
import 'package:abo_sadah/core/widgets/Inputs/Input.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

class AddAttendances extends StatelessWidget {
  const AddAttendances({super.key, required this.group});

  final GroupsEntity group;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            spacing: 10,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("مجموعة ${group.id}", style: TextStyle(fontSize: 20)),

                  Button(
                    title: "الرجوع",
                    icon: LucideIcons.chevronRight,
                    padding: EdgeInsets.all(10),
                    fontSize: 10,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: ThemeColors.forground,
                  borderRadius: BorderRadius.circular(24),
                ),
                margin: EdgeInsets.symmetric(vertical: 5),
                child: ListTile(
                  title: Consumer<AppData>(
                    builder: (context, data, child) => Text(
                      "عدد الحضور: ${data.attendances.where((e) => e.groupID == group.id && e.createdTime.day == DateTime.now().day).length} من ${group.students!.length}",
                    ),
                  ),
                  subtitle: Text(
                    group.timeGroups!.map((e) => e.day).join(" - "),
                  ),
                  trailing: Text(
                    "مجموعة ${group.id}",
                    style: TextStyles.trailing,
                  ),
                ),
              ),
              Input(
                title: "ابحث عن طالب",
                style: "border",
                prefixIcon: Icons.search,
                // controller: search,
                // onChanged: (value) => setState(() {
                //   students = allStudents
                //       .where((stud) => stud.name.contains(value.toString()))
                //       .toList();
                // }),
              ),

              Consumer<AppData>(
                builder: (context, data, child) {
                  final DateTime today = DateTime.now();
                  final students = data.students
                      .where((stud) => stud.groupID == group.id)
                      .toList();
                  return Column(
                    children: List.generate(students.length, (index) {
                      final student = students[index];
                      AttendancesEntity? attendedData;
                      try {
                        attendedData = data.attendances.firstWhere((att) {
                          DateTime attDate = att.createdTime;
                          return att.studentID == student.id &&
                              att.groupID == group.id &&
                              attDate.year == today.year &&
                              attDate.month == today.month &&
                              attDate.day == today.day;
                        });
                      } catch (e) {
                        attendedData = null;
                      }

                      bool isAttended = attendedData != null;

                      return Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: ThemeColors.forground,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: ListTile(
                          leading: Icon(LucideIcons.user),
                          title: Text(student.name),
                          subtitle: Text(student.phone),
                          trailing: Checkbox(
                            value: isAttended,
                            onChanged: (v) {
                              if (v == true) {
                                data.addAttendance(
                                  AttendancesEntity(
                                    studentID: student.id!,
                                    groupID: group.id!,
                                    grade: 0,
                                    status: 0,
                                    createdTime: DateTime.now(),
                                  ),
                                );
                              } else {
                                if (attendedData != null) {
                                  data.deleteAttendance(attendedData.id!);
                                }
                              }
                            },
                          ),
                        ),
                      );
                    }),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
