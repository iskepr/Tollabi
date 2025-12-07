import 'package:abo_sadah/core/Data/all.dart';
import 'package:abo_sadah/core/Data/typs.dart';
import 'package:abo_sadah/core/Theme/Colors.dart';
import 'package:abo_sadah/core/widgets/Button.dart';
import 'package:abo_sadah/core/widgets/Grid.dart';
import 'package:abo_sadah/core/widgets/Inputs/Input.dart';
import 'package:abo_sadah/core/widgets/Students/add.dart';
import 'package:abo_sadah/pages/Students/StudAcount.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

class Students extends StatelessWidget {
  Students({super.key});

  List<StudentsEntity> students = [];
  TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<AppData>(
      builder: (context, data, child) => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("كل الطلاب", style: TextStyle(fontSize: 20)),
              Button(
                title: "+ إضافة طالب",
                fontSize: 14,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                radius: 16,
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => AddStud(),
                  );
                },
              ),
            ],
          ),
          SizedBox(height: 10),
          Input(
            title: "ابحث عن طالب",
            style: "border",
            prefixIcon: Icons.search,
            controller: search,
            onChanged: (value) => students = data.students
                .where((stud) => stud.name.contains(value))
                .toList(),
          ),
          SizedBox(height: 10),
          MyGrid(
            count: students.length,
            child: (BuildContext context, int index) => GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        StudAcount(studentData: students[index]),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: ThemeColors.forground,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    students[index].name,
                    style: TextStyle(fontSize: 14),
                  ),
                  subtitle: Text(
                    students[index].phone,
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
    );
  }
}
