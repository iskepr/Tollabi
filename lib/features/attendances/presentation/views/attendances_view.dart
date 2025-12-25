import 'package:abo_sadah/core/Theme/TextStyles.dart';
import 'package:abo_sadah/core/data/typs.dart';
import 'package:abo_sadah/core/widgets/Inputs/Input.dart';
import 'package:abo_sadah/features/attendances/presentation/views/widgets/add_attendances.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:abo_sadah/core/data/all.dart';
import 'package:abo_sadah/core/Theme/Colors.dart';

class AttendancesView extends StatefulWidget {
  const AttendancesView({super.key});

  @override
  State<AttendancesView> createState() => _AttendancesViewState();
}

class _AttendancesViewState extends State<AttendancesView> {
  List<GroupsEntity> allGroups = [];
  List<GroupsEntity> groups = [];
  TextEditingController search = TextEditingController();

  @override
  void initState() {
    super.initState();
    String todayName = DateFormat('EEEE').format(DateTime.now());
    final data = Provider.of<AppData>(context, listen: false);
    allGroups = data.groups
        .where((g) => g.timeGroups?.any((t) => t.day == todayName) ?? false)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("حُضور مجموعات اليوم", style: TextStyle(fontSize: 20)),
          ],
        ),
        Input(
          title: "ابحث عن مجموعة",
          style: "border",
          prefixIcon: Icons.search,
          controller: search,
          onChanged: (value) => setState(() {
            groups = allGroups
                .where((stud) => stud.id == value.toString())
                .toList();
          }),
        ),

        Consumer<AppData>(
          builder: (context, data, child) {
            return Column(
              spacing: 10,
              children: List.generate(allGroups.length, (index) {
                final group = data.groups[index];
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
            );
          },
        ),
      ],
    );
  }
}
