import 'package:tollabi/core/Theme/text_styles.dart';
import 'package:tollabi/core/data/typs.dart';
import 'package:tollabi/features/attendances/presentation/views/widgets/add_attendances.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tollabi/core/data/all.dart';
import 'package:tollabi/core/Theme/colors.dart';

class AttendancesView extends StatefulWidget {
  const AttendancesView({super.key});

  @override
  State<AttendancesView> createState() => _AttendancesViewState();
}

class _AttendancesViewState extends State<AttendancesView> {
  List<GroupsEntity> groups = [];

  @override
  void initState() {
    super.initState();
    String todayName = DateFormat('EEEE').format(DateTime.now());
    final data = Provider.of<AppData>(context, listen: false);
    groups = data.groups
        .where((g) => g.timeGroups?.any((t) => t.day == todayName) ?? false)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("مجموعات اليوم", style: TextStyle(fontSize: 20)),
            SizedBox(height: 40),
          ],
        ),

        Consumer<AppData>(
          builder: (context, data, child) {
            if (groups.isEmpty) {
              return Text("لا يوجد مجموعات لليوم");
            }
            return Column(
              spacing: 10,
              children: List.generate(groups.length, (index) {
                final group = groups[index];
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddAttendances(group: group),
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: ThemeColors.forground,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ListTile(
                      title: Text(
                        "عدد الحضور: ${data.attendances.where((e) => e.groupID == group.id && e.createdTime.day == DateTime.now().day).length} من ${group.students!.length}",
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
                );
              }),
            );
          },
        ),
      ],
    );
  }
}
