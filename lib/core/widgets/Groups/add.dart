import 'package:abo_sadah/core/Data/all.dart';
import 'package:abo_sadah/core/Data/typs.dart';
import 'package:abo_sadah/core/sqflite/mySql.dart';
import 'package:abo_sadah/core/widgets/BottomSheet.dart';
import 'package:abo_sadah/core/widgets/Button.dart';
import 'package:abo_sadah/core/widgets/Inputs/Input.dart';
import 'package:abo_sadah/core/widgets/Inputs/Select.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddGroup extends StatefulWidget {
  const AddGroup({super.key});

  @override
  State<AddGroup> createState() => _AddGroupState();
}

class _AddGroupState extends State<AddGroup> {
  final List days = AppData.days;
  final List times = AppData.times;

  final Map<String, TextEditingController> c = {
    "day1": TextEditingController(),
    "day2": TextEditingController(),
    "startTime": TextEditingController(),
    "endTime": TextEditingController(),
    "isAM": TextEditingController(),
    "price": TextEditingController(),
    "grade": TextEditingController(),
  };

  Widget _fildBuilder(String title, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        child,
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    if (days.isNotEmpty) {
      c["day1"]!.text = days.first;
      c["day2"]!.text = days.first;
      c["isAM"]!.text = times.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<AppData>(context);
    return MyBottomsheet(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                "إضافة مجموعة جديدة",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

            _fildBuilder(
              "ايام المجموعة",
              Row(
                spacing: 10,
                children: [
                  Expanded(
                    child: Input(
                      title: "اختر اليوم",
                      type: "select",
                      value: c["day1"]!.text,
                      items: days
                          .map((day) => SelectItem(title: day, value: day))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          c["day1"]!.text = value;
                        });
                      },
                      controller: c["day1"]!,
                    ),
                  ),
                  Expanded(
                    child: Input(
                      title: "اختر اليوم",
                      type: "select",
                      value: c["day2"]!.text,
                      items: days
                          .map((day) => SelectItem(title: day, value: day))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          c["day2"]!.text = value;
                        });
                      },
                      controller: c["day2"]!,
                    ),
                  ),
                ],
              ),
            ),

            // Time Selection
            _fildBuilder(
              "مواعيد المجموعة",
              Row(
                spacing: 10,
                children: [
                  Expanded(
                    child: Input(title: "من", controller: c["startTime"]!),
                  ),
                  Expanded(
                    child: Input(title: "الى", controller: c["endTime"]!),
                  ),
                  Expanded(
                    child: Input(
                      title: "الفترة",
                      type: "select",
                      value: c["isAM"]!.text,
                      items: times
                          .map((time) => SelectItem(title: time, value: time))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          c["isAM"]!.text = value;
                        });
                      },
                      controller: c["isAM"]!,
                    ),
                  ),
                ],
              ),
            ),

            _fildBuilder(
              "سعر الحصة",
              Input(title: "سعر الحصة", controller: c["price"]!),
            ),

            _fildBuilder(
              "درجة الحصة",
              Input(title: "درجة الحصة", controller: c["grade"]!),
            ),

            const SizedBox(height: 20),

            Button(
              title: "إضافة",
              onTap: () async {
                if (c["startTime"]!.text.isEmpty || c["price"]!.text.isEmpty) {
                  return;
                }

                data.addGroup(
                  GroupsEntity(
                    day1: c["day1"]!.text,
                    day2: c["day2"]!.text,
                    startTime: double.parse(c["startTime"]!.text),
                    endTime: double.parse(c["endTime"]!.text),
                    isAM: c["isAM"]!.text == times.first ? true : false,
                    price: double.parse(c["price"]!.text),
                    grade: double.parse(c["grade"]!.text),
                  ),
                );

                print(await MySqfLite().query('groups'));

                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
