import 'package:abo_sadah/core/Data/all.dart';
import 'package:abo_sadah/core/Data/typs.dart';
import 'package:abo_sadah/core/Theme/TextStyles.dart';
import 'package:abo_sadah/core/widgets/BottomSheet.dart';
import 'package:abo_sadah/core/widgets/Button.dart';
import 'package:abo_sadah/core/widgets/Inputs/Input.dart';
import 'package:abo_sadah/core/widgets/Inputs/Select.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditStud extends StatelessWidget {
  EditStud({super.key, required this.studentData});

  final StudentsEntity studentData;

  final Map<String, TextEditingController> c = {
    "img": TextEditingController(),
    "name": TextEditingController(),
    "phone": TextEditingController(),
    "groupID": TextEditingController(),
  };

  @override
  Widget build(BuildContext context) {
    return MyBottomsheet(
      child: Column(
        spacing: 5,
        children: [
          Text("تعديل بيانات الطالب", style: TextStyles.title),
          Input(
            title: "الاسم",
            value: studentData.name,
            controller: c["name"]!,
          ),
          Input(
            title: "الهاتف",
            value: studentData.phone,
            controller: c["phone"]!,
          ),
          Consumer<AppData>(
            builder: (context, data, child) => Input(
              title: "المجموعة",
              controller: c["groupID"]!,
              type: "select",
              value: data.groups
                  .firstWhere((group) => group.id == studentData.groupId)
                  .id
                  .toString(),
              items: data.groups
                  .map(
                    (group) => SelectItem(
                      title: "المجموعة ${group.id}",
                      value: group.id.toString(),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                c["groupID"]!.text = data.groups
                    .firstWhere((group) => group.id == int.parse(value))
                    .id
                    .toString();
              },
            ),
          ),
          SizedBox(height: 10),
          Button(
            title: "حفظ",
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
