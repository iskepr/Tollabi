import 'package:abo_sadah/core/Data/all.dart';
import 'package:abo_sadah/core/Theme/Colors.dart';
import 'package:abo_sadah/core/Theme/TextStyles.dart';
import 'package:abo_sadah/core/widgets/Button.dart';
import 'package:abo_sadah/core/widgets/Input.dart';
import 'package:abo_sadah/core/widgets/Students/addStud.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class Group extends StatelessWidget {
  Group({super.key, required this.group});

  final Map<String, dynamic> group;
  List<Map<String, dynamic>> get students => group["students"] = AppData
      .students
      .where((student) => student["groupID"] == group["id"])
      .toList();

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
                  Text(group["name"], style: TextStyle(fontSize: 20)),
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
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) => AddStud(),
                          );
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
              SizedBox(height: 10),
              Row(
                children: [
                  Button(
                    title: "تعديل",
                    icon: LucideIcons.squarePen,
                    padding: EdgeInsets.all(10),
                    onTap: () {},
                  ),
                  SizedBox(width: 10),
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
                        subtitle: Text(group["days"]),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(group["name"], style: TextStyles.trailing),
                            Text(group["time"], style: TextStyles.trailing),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Input(
                title: "ابحث عن طالب",
                style: "border",
                prefixIcon: Icons.search,
                controller: controller,
              ),
              SizedBox(height: 10),
              Column(
                children: List.generate(students.length, (index) {
                  final student = students[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: ThemeColors.forground,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(student["img"] ?? ""),
                      ),
                      title: Text(student["name"]),
                      subtitle: Text(student["phone"]),
                      trailing: Button(
                        title: "إعطاء درجة التاسك",
                        fontSize: 10,
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        onTap: () {},
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
