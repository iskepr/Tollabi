import 'package:abo_sadah/core/data/all.dart';
import 'package:abo_sadah/core/Theme/Colors.dart';
import 'package:abo_sadah/core/Theme/TextStyles.dart';
import 'package:abo_sadah/core/widgets/Button.dart';
import 'package:abo_sadah/features/groups/presentation/views/widgets/add.dart';
import 'package:abo_sadah/features/groups/presentation/views/group_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GroupsView extends StatelessWidget {
  const GroupsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
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
        Consumer<AppData>(
          builder: (context, data, child) => Column(
            children: List.generate(data.groups.length, (index) {
              final group = data.groups[index];
              group.students = data.students
                  .where((student) => student.groupID == group.id)
                  .toList();
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GroupView(group: group),
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: ThemeColors.forground,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: ListTile(
                    title: Text("عدد الطلاب: ${group.students!.length}"),
                    // subtitle: Text("${group.day1} - ${group.day2}"),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("مجموعة ${group.id}", style: TextStyles.trailing),
                        // Text(
                        //   "${group.startTime} : ${group.endTime}",
                        //   style: TextStyles.trailing,
                        // ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
