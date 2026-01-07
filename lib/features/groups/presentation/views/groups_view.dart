import 'package:abo_sadah/core/data/all.dart';
import 'package:abo_sadah/core/Theme/colors.dart';
import 'package:abo_sadah/core/Theme/text_styles.dart';
import 'package:abo_sadah/core/widgets/inputs/custom_button.dart';
import 'package:abo_sadah/features/groups/presentation/views/widgets/add_group.dart';
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
            CustomButton(
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
          builder: (context, data, child) => data.groups.isEmpty
              ? Center(child: Text("لا يوجد مجموعات"))
              : Column(
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
                          subtitle: Text(
                            group.timeGroups!.map((e) => e.day).join(" - "),
                          ),
                          trailing: Text(
                            "مجموعة ${group.id}",
                            style: TextStyles.trailing,
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
