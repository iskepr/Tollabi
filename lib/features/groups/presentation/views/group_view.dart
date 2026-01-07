import 'package:abo_sadah/core/data/all.dart';
import 'package:abo_sadah/core/data/typs.dart';
import 'package:abo_sadah/core/Theme/Colors.dart';
import 'package:abo_sadah/core/Theme/TextStyles.dart';
import 'package:abo_sadah/core/utils/format.dart';
import 'package:abo_sadah/core/widgets/Inputs/custom_button.dart';
import 'package:abo_sadah/features/groups/presentation/views/widgets/add_students_in_group.dart';
import 'package:abo_sadah/features/groups/presentation/views/widgets/all_group_students.dart';
import 'package:abo_sadah/features/groups/presentation/views/widgets/edit_group.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

class GroupView extends StatefulWidget {
  const GroupView({super.key, required this.group});

  final GroupsEntity group;

  @override
  State<GroupView> createState() => _GroupViewState();
}

class _GroupViewState extends State<GroupView> {
  bool isAddStudent = false;
  late GroupsEntity group;

  @override
  void initState() {
    super.initState();
    group = widget.group;
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<AppData>(context);
    group = data.groups.firstWhere((g) => g.id == group.id);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              spacing: 10,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("مجموعة ${group.id}", style: TextStyle(fontSize: 20)),
                    Row(
                      spacing: 5,
                      children: [
                        if (!isAddStudent)
                          CustomButton(
                            title: "إضافة طالب للمجموعة",
                            fontSize: 14,
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 11,
                            ),
                            onTap: () {
                              setState(() => isAddStudent = true);
                            },
                          ),
                        CustomButton(
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
                  ],
                ),
                Row(
                  spacing: 10,
                  children: [
                    if (!isAddStudent)
                      CustomButton(
                        title: "تعديل",
                        icon: LucideIcons.squarePen,
                        padding: EdgeInsets.all(10),
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) => EditGroup(groupData: group),
                          );
                        },
                      ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: ThemeColors.forground,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                "عدد الطلاب: ${group.students!.length}",
                              ),
                              subtitle: Text(
                                group.timeGroups!.map((e) => e.day).join(" - "),
                              ),
                              trailing: Text(
                                "مجموعة ${group.id}",
                                style: TextStyles.trailing,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "السعر ${formatDouble(group.price)} جنية",
                                  style: TextStyles.trailing,
                                ),
                                Text(
                                  "الدرجة ${formatDouble(group.grade)}",
                                  style: TextStyles.trailing,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                if (!isAddStudent) AllGroupStudents(group: group),
                if (isAddStudent)
                  Column(
                    children: [
                      AddStudentsInGroup(group: group),
                      CustomButton(
                        title: "موافق",
                        padding: EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 10,
                        ),
                        fontSize: 16,
                        radius: 16,
                        onTap: () {
                          setState(() => isAddStudent = false);
                        },
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
