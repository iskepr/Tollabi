import 'package:tollabi/core/Theme/colors.dart';
import 'package:tollabi/core/data/all.dart';
import 'package:tollabi/core/utils/format.dart';
import 'package:tollabi/core/widgets/inputs/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudentAttendData extends StatefulWidget {
  const StudentAttendData({super.key, required this.studentID});

  final int studentID;

  @override
  State<StudentAttendData> createState() => _StudentAttendDataState();
}

class _StudentAttendDataState extends State<StudentAttendData> {
  int selectedGroup = 0;

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<AppData>(context);
    final allAttends = data.attendances
        .where((a) => a.studentID == widget.studentID)
        .toList();
    final attendGroups = allAttends.map((a) => a.groupID).toSet().toList();
    final groupAttends = allAttends
        .where((a) => a.groupID == data.groups[selectedGroup].id)
        .toList();

    if (allAttends.isEmpty) {
      return Text("لم يحضر الطالب من قبل");
    }
    return Column(
      children: [
        SizedBox(
          height: 40,
          child: ListView.separated(
            itemCount: attendGroups.length,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(right: 15),
            separatorBuilder: (context, index) => const SizedBox(width: 5),
            itemBuilder: (context, index) {
              final groupData = data.groups.firstWhere(
                (g) => g.id == attendGroups[index],
              );
              return CustomButton(
                title: "المجموعة ${groupData.id}",
                active: selectedGroup == index,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                onTap: () {
                  setState(() {
                    selectedGroup = index;
                  });
                },
              );
            },
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: List.generate(groupAttends.length, (index) {
              return Container(
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: ThemeColors.forground,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: ListTile(
                  title: Text(
                    "الدرجة: ${formatDouble(groupAttends[index].grade)}",
                  ),
                  subtitle: Text(
                    "السعر: ${formatDouble(groupAttends[index].price)}",
                  ),
                  trailing: Text(
                    "التاريخ: ${formatTime(groupAttends[index].createdTime).formatH}",
                    style: TextStyle(fontSize: 12),
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
