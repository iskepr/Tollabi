import 'package:abo_sadah/core/Data/all.dart';
import 'package:abo_sadah/core/Data/typs.dart';
import 'package:abo_sadah/core/Theme/Colors.dart';
import 'package:abo_sadah/core/Theme/TextStyles.dart';
import 'package:abo_sadah/core/widgets/Button.dart';
import 'package:abo_sadah/core/widgets/Grid.dart';
import 'package:abo_sadah/core/widgets/Inputs/Input.dart';
import 'package:abo_sadah/core/widgets/Students/edit.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class StudAcount extends StatelessWidget {
  StudAcount({super.key, required this.studentData});

  final StudentsEntity studentData;

  List<TasksEntity> tasks = AppData.tasks;
  int get group =>
      AppData.groups.firstWhere((group) => studentData.groupId == group.id).id;

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("حساب الطلاب", style: TextStyle(fontSize: 20)),
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
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: ThemeColors.forground),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: ListTile(
                  leading: Icon(LucideIcons.user),
                  title: Text(studentData.name),
                  subtitle: Text(studentData.phone),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) =>
                                EditStud(studentData: studentData),
                          );
                        },
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                        icon: Icon(LucideIcons.squarePen, size: 14),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "مجموعة ${group.toString()}",
                        style: TextStyles.trailing,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Input(
                title: "ابحث عن مهمة",
                style: "border",
                prefixIcon: Icons.search,
                controller: controller,
              ),
              SizedBox(height: 10),
              MyGrid(
                count: tasks.length,
                child: (BuildContext context, int index) {
                  final time = tasks[index].time;
                  return Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: ThemeColors.forground,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      title: Text(tasks[index].title),
                      subtitle: Text("${tasks[index].score}/10"),
                      trailing: Text(
                        "${time.day}/${time.month}/${time.year}",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
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
