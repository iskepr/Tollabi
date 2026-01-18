import 'package:tollabi/core/Theme/colors.dart';
import 'package:tollabi/core/data/all.dart';
import 'package:tollabi/core/data/typs.dart';
import 'package:tollabi/core/widgets/inputs/custom_checkbox.dart';
import 'package:tollabi/core/widgets/custom_grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddStudentsInGroup extends StatelessWidget {
  const AddStudentsInGroup({super.key, required this.group});

  final GroupsEntity group;

  @override
  Widget build(BuildContext context) {
    final screenHight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        SizedBox(
          height: screenHight * 0.63,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "إختر الطلاب:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: screenHight * 0.55,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Consumer<AppData>(
                    builder: (context, data, child) => CustomGrid(
                      count: data.students.length,
                      emptyText: "لا يوجد طلاب",
                      child: (BuildContext context, int index) {
                        bool isCheck = data.students[index].groupID == group.id;
                        return Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: ThemeColors.forground,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            leading: CustomCheckbox(
                              value: isCheck
                                  ? "true"
                                  : (data.groups.isEmpty
                                            ? null
                                            : data.groups
                                                  .firstWhere(
                                                    (g) =>
                                                        g.id ==
                                                        data
                                                            .students[index]
                                                            .groupID,
                                                    orElse: () => GroupsEntity(
                                                      id: null,
                                                      price: 0.0,
                                                      grade: 0.0,
                                                    ),
                                                  )
                                                  .id)
                                        .toString(),
                              onChanged: (val) {
                                print(val);
                                if (val == "true") {
                                  data.students[index].groupID = group.id;
                                } else {
                                  data.students[index].groupID = null;
                                }
                                data.editStudent(data.students[index]);
                              },
                            ),
                            title: Text(
                              data.students[index].name,
                              style: TextStyle(fontSize: 14),
                            ),
                            subtitle: Text(
                              data.students[index].phone,
                              textDirection: TextDirection.ltr,
                              textAlign: TextAlign.right,
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
