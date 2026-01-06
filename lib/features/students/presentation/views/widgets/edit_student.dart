import 'package:abo_sadah/core/data/all.dart';
import 'package:abo_sadah/core/data/typs.dart';
import 'package:abo_sadah/core/Theme/TextStyles.dart';
import 'package:abo_sadah/core/widgets/custom_bottom_sheet.dart';
import 'package:abo_sadah/core/widgets/custom_button.dart';
import 'package:abo_sadah/core/widgets/Inputs/Input.dart';
import 'package:abo_sadah/core/widgets/Inputs/Select.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditStud extends StatelessWidget {
  EditStud({super.key, required this.studentData});

  final StudentsEntity studentData;

  final Map<String, TextEditingController> c = {
    "name": TextEditingController(),
    "phone": TextEditingController(),
    "groupID": TextEditingController(),
  };

  final String gTitle = "اختر مجموعة";

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<AppData>(context, listen: false);
    c["groupID"]!.text = studentData.groupID == null
        ? gTitle
        : data.groups
              .firstWhere((group) => group.id == studentData.groupID)
              .id
              .toString();
    return CustomBottomSheet(
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
              title: gTitle,
              controller: c["groupID"]!,
              type: "select",
              value: c["groupID"]!.text,
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
                    .firstWhere(
                      (group) => group.id == int.parse(value.toString()),
                    )
                    .id
                    .toString();
              },
            ),
          ),
          const SizedBox(height: 30),
          CustomButton(
            title: "حفظ",
            onTap: () {
              final groupID = c["groupID"]!.text == gTitle
                  ? null
                  : int.parse(c["groupID"]!.text);
              data.editStudent(
                StudentsEntity(
                  id: studentData.id,
                  groupID: groupID,
                  name: c["name"]!.text,
                  phone: c["phone"]!.text,
                  createdTime: studentData.createdTime,
                ),
              );
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
