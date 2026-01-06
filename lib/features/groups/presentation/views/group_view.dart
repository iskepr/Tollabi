import 'package:abo_sadah/core/data/all.dart';
import 'package:abo_sadah/core/data/typs.dart';
import 'package:abo_sadah/core/Theme/Colors.dart';
import 'package:abo_sadah/core/Theme/TextStyles.dart';
import 'package:abo_sadah/core/widgets/custom_button.dart';
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
                  Text(
                    "مجموعة ${widget.group.id}",
                    style: TextStyle(fontSize: 20),
                  ),
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
                          builder: (context) => EditGroup(),
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
                      child: ListTile(
                        title: Consumer<AppData>(
                          builder: (context, data, child) => Text(
                            "عدد الطلاب: ${(data.students).where((e) => e.groupID == widget.group.id).length}",
                          ),
                        ),
                        subtitle: Text(
                          widget.group.timeGroups!
                              .map((e) => e.day)
                              .join(" - "),
                        ),
                        trailing: Text(
                          "مجموعة ${widget.group.id}",
                          style: TextStyles.trailing,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (!isAddStudent) AllGroupStudents(group: widget.group),
              if (isAddStudent)
                Column(
                  children: [
                    AddStudentsInGroup(group: widget.group),
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
    );
  }
}
