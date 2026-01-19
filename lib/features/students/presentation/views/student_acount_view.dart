import 'package:tollabi/core/data/all.dart';
import 'package:tollabi/core/Theme/colors.dart';
import 'package:tollabi/core/Theme/text_styles.dart';
import 'package:tollabi/core/widgets/confirm_delete.dart';
import 'package:tollabi/core/widgets/inputs/custom_button.dart';
import 'package:tollabi/features/students/presentation/views/widgets/edit_student.dart';
import 'package:tollabi/features/students/presentation/views/widgets/student_attend_data.dart';
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
                          return Column(
                            children: [
                              ListTile(
                                contentPadding: EdgeInsets.only(
                                  right: 10,
                                  left: 5,
                                  top: 5,
                                  bottom: 5,
                                ),
                                leading: Icon(LucideIcons.user),
                                title: Text(studentData.name),
                                subtitle: Text(studentData.phone),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          builder: (context) => ConfirmDelete(
                                            title: "الطالب",
                                            onConfirm: () {
                                              data.deleteStudent(
                                                studentData.id!,
                                              );
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                            },
                                          ),
                                        );
                                      },
                                      constraints: const BoxConstraints(),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 5,
                                      ),
                                      icon: const Icon(
                                        LucideIcons.trash,
                                        color: ThemeColors.error,
                                        size: 14,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          builder: (context) => EditStud(
                                            studentData: studentData,
                                          ),
                                        );
                                      },
                                      constraints: const BoxConstraints(),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 5,
                                      ),
                                      icon: const Icon(
                                        LucideIcons.squarePen,
                                        size: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                "مجموعة ${studentData.groupID == null ? "غير محددة" : data.groups.firstWhere((group) => studentData.groupID == group.id).id}",
                                style: TextStyles.trailing,
                              ),
                              const SizedBox(height: 10),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              StudentAttendData(studentID: studentID),
            ],
          ),
        ),
      ),
    );
  }
}
