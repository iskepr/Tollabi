import 'package:abo_sadah/core/data/all.dart';
import 'package:abo_sadah/core/Theme/Colors.dart';
import 'package:abo_sadah/core/Theme/TextStyles.dart';
import 'package:abo_sadah/core/widgets/Inputs/custom_button.dart';
import 'package:abo_sadah/features/students/presentation/views/widgets/edit_student.dart';
import 'package:abo_sadah/features/students/presentation/views/widgets/student_attend_data.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

class StudentAcountView extends StatelessWidget {
  StudentAcountView({super.key, required this.studentID});

  final int studentID;

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  spacing: 10,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("حساب الطلاب", style: TextStyle(fontSize: 20)),
                        CustomButton(
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
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: ThemeColors.forground),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Consumer<AppData>(
                        builder: (context, data, child) {
                          final studentData = data.students.firstWhere(
                            (stud) => stud.id == studentID,
                          );
                          return ListTile(
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
                                const SizedBox(height: 5),
                                Text(
                                  "مجموعة ${studentData.groupID == null ? "غير محددة" : data.groups.firstWhere((group) => studentData.groupID == group.id).id}",
                                  style: TextStyles.trailing,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              StudentAttendData(studentID: studentID,),
            ],
          ),
        ),
      ),
    );
  }
}
