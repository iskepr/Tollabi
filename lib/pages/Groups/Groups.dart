import 'package:abo_sadah/core/Data/all.dart';
import 'package:abo_sadah/core/Theme/Colors.dart';
import 'package:abo_sadah/core/Theme/TextStyles.dart';
import 'package:abo_sadah/core/widgets/Button.dart';
import 'package:abo_sadah/core/widgets/Groups/add.dart';
import 'package:abo_sadah/pages/Groups/Group.dart';
import 'package:flutter/material.dart';

class Groups extends StatelessWidget {
  Groups({super.key});

  final List<Map<String, dynamic>> groups = AppData.groups;
  final List<Map<String, dynamic>> students = AppData.students;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("المجموعات", style: TextStyle(fontSize: 20)),
            Button(
              title: "+ إضافة مجموعة",
              fontSize: 14,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              radius: 16,
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => AddGroup(),
                );
              },
            ),
          ],
        ),
        SizedBox(height: 10),
        Column(
          children: List.generate(groups.length, (index) {
            final group = groups[index];
            group["students"] = students
                .where((student) => student["groupID"] == group["id"])
                .toList();
            return GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Group(group: group)),
              ),
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: ThemeColors.forground,
                  borderRadius: BorderRadius.circular(24),
                ),
                margin: EdgeInsets.symmetric(vertical: 5),
                child: ListTile(
                  title: Text("عدد الطلاب: ${group["students"].length}"),
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
            );
          }),
        ),
      ],
    );
  }
}
