import 'package:abo_sadah/core/data/all.dart';
import 'package:abo_sadah/core/data/typs.dart';
import 'package:abo_sadah/core/Theme/Colors.dart';
import 'package:abo_sadah/core/Theme/TextStyles.dart';
import 'package:abo_sadah/core/widgets/Button.dart';
import 'package:abo_sadah/core/widgets/Inputs/Input.dart';
import 'package:abo_sadah/features/students/presentation/views/widgets/edit.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

class StudentAcountView extends StatelessWidget {
  StudentAcountView({super.key, required this.studentData});

  final StudentsEntity studentData;

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
                  Text("حساب الطلاب", style: TextStyle(fontSize: 20)),
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
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: ThemeColors.forground),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: ListTile(
                  leading: Icon(LucideIcons.user),
                  title: Text(studentData.name),
                  subtitle: Text(studentData.phone),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) =>
                                EditStud(studentData: studentData),
                          );
                        },
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                        icon: Icon(LucideIcons.squarePen, size: 14),
                      ),
                      SizedBox(height: 5),
                      Consumer<AppData>(
                        builder: (context, data, child) => Text(
                          "مجموعة ${studentData.groupID == null ? "غير محددة" : data.groups.firstWhere((group) => studentData.groupID == group.id).id}",
                          style: TextStyles.trailing,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Input(
                title: "ابحث عن مهمة",
                style: "border",
                prefixIcon: Icons.search,
                controller: controller,
              ),
              SizedBox(height: 10),
              // Consumer<AppData>(
              //   builder: (context, data, child) => MyGrid(
              //     count: data.tasks.length,
              //     child: (BuildContext context, int index) {
              //       final time = data.tasks[index].time;
              //       return Container(
              //         padding: EdgeInsets.all(5),
              //         decoration: BoxDecoration(
              //           color: ThemeColors.forground,
              //           borderRadius: BorderRadius.circular(24),
              //         ),
              //         child: ListTile(
              //           contentPadding: EdgeInsets.symmetric(horizontal: 10),
              //           title: Text(data.tasks[index].title),
              //           subtitle: Text("${data.tasks[index].score}/10"),
              //           trailing: Text(
              //             "${time.day}/${time.month}/${time.year}",
              //             style: TextStyle(fontSize: 14),
              //           ),
              //         ),
              //       );
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
