import 'package:abo_sadah/core/Theme/Colors.dart';
import 'package:abo_sadah/core/data/all.dart';
import 'package:abo_sadah/core/data/typs.dart';
import 'package:abo_sadah/core/widgets/Grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddStudentsInGroup extends StatelessWidget {
  const AddStudentsInGroup({super.key, required this.group});

  final GroupsEntity group;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.65,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "إختر الطلاب:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Consumer<AppData>(
                builder: (context, data, child) => MyGrid(
                  count: data.students.length,
                  child: (BuildContext context, int index) {
                    bool isCheck = data.students[index].groupID == group.id;
                    return GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: ThemeColors.forground,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Row(
                          children: [
                            Checkbox(
                              value: isCheck,
                              onChanged: (val) {
                                if (val == null) return;
                                if (val == true) {
                                  data.students[index].groupID = group.id;
                                } else {
                                  data.students[index].groupID = null;
                                }
                                data.editStudent(data.students[index]);
                              },
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  data.students[index].name,
                                  style: TextStyle(fontSize: 14),
                                ),
                                Text(
                                  data.students[index].phone,
                                  textDirection: TextDirection.ltr,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
