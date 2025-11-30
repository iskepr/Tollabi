import 'package:abo_sadah/core/Data/all.dart';
import 'package:abo_sadah/core/Theme/Colors.dart';
import 'package:abo_sadah/core/Theme/TextStyles.dart';
import 'package:abo_sadah/core/widgets/Button.dart';
import 'package:abo_sadah/core/widgets/Grid.dart';
import 'package:abo_sadah/core/widgets/Groups/addScore.dart';
import 'package:abo_sadah/core/widgets/Groups/edit.dart';
import 'package:abo_sadah/core/widgets/Inputs/Input.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class Group extends StatefulWidget {
  const Group({super.key, required this.group});

  final Map<String, dynamic> group;

  @override
  State<Group> createState() => _GroupState();
}

class _GroupState extends State<Group> {
  List<Map<String, dynamic>> get students => widget.group["students"] = AppData
      .students
      .where((student) => student["groupID"] == widget.group["id"])
      .toList();

  TextEditingController controller = TextEditingController();

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
                  Text(widget.group["name"], style: TextStyle(fontSize: 20)),
                  Row(
                    children: [
                      Button(
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
                      SizedBox(width: 5),
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
                ],
              ),
              Row(
                spacing: 10,
                children: [
                  if (!isAddStudent)
                    Button(
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
                        title: Text("عدد الطلاب: ${students.length}"),
                        subtitle: Text(widget.group["days"]),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              widget.group["name"],
                              style: TextStyles.trailing,
                            ),
                            Text(
                              widget.group["time"],
                              style: TextStyles.trailing,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (!isAddStudent)
                Column(
                  spacing: 10,
                  children: [
                    Input(
                      title: "ابحث عن طالب",
                      style: "border",
                      prefixIcon: Icons.search,
                      controller: controller,
                    ),
                    Column(
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
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            leading: Icon(LucideIcons.user),
                            title: Text(student["name"]),
                            subtitle: Text(student["phone"]),
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
                    ),
                  ],
                ),

              if (isAddStudent)
                Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.65,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "إختر الطلاب:",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          MyGrid(
                            count: students.length,
                            child: (BuildContext context, int index) =>
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: ThemeColors.forground,
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    child: ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      title: Text(
                                        students[index]["name"],
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      subtitle: Text(
                                        students[index]["phone"],
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
                      ),
                    ),
                    Button(
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
