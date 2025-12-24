import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:abo_sadah/core/data/all.dart';
import 'package:abo_sadah/core/Theme/Colors.dart';

class AttendancesView extends StatelessWidget {
  const AttendancesView({super.key});

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

        Consumer<AppData>(
          builder: (context, data, child) {
            return Column(
              spacing: 10,
              children: List.generate(
                data.attendances.length,
                (index) => Container(
                  decoration: BoxDecoration(
                    color: ThemeColors.forground,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    title: Text(data.attendances[index].groupID.toString()),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
