import 'package:tollabi/core/data/all.dart';
import 'package:tollabi/core/data/typs.dart';
import 'package:tollabi/core/functions/show_message.dart';
import 'package:tollabi/core/widgets/custom_bottom_sheet.dart';
import 'package:tollabi/core/widgets/inputs/custom_button.dart';
import 'package:tollabi/core/widgets/inputs/input.dart';
import 'package:tollabi/core/widgets/inputs/select.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

class AddGroup extends StatefulWidget {
  const AddGroup({super.key});

  @override
  State<AddGroup> createState() => _AddGroupState();
}

class _AddGroupState extends State<AddGroup> {
  final List days = AppData.days;
  List<TimeGroupsEntity> groupDays = [];

  final Map<String, TextEditingController> c = {
    "price": TextEditingController(),
    "grade": TextEditingController(text: "10"),
  };

  @override
  void initState() {
    super.initState();
    _addNewDay();
  }

  void _addNewDay() {
    groupDays.add(
      TimeGroupsEntity(
        day: days.first,
        startTime: Time(hour: 12, minute: 0),
        endTime: Time(hour: 13, minute: 0),
      ),
    );
  }

  Widget _fildBuilder(String title, Widget child, {Widget? withDelete}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            withDelete ?? Container(),
          ],
        ),
        const SizedBox(height: 5),
        child,
        const SizedBox(height: 10),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<AppData>(context, listen: false);

    return CustomBottomSheet(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "إضافة مجموعة جديدة",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              Column(
                spacing: 10,
                children: List.generate(groupDays.length, (index) {
                  final d = groupDays[index];

                  return _fildBuilder(
                    "مواعيد المجموعة ${index + 1}",
                    Column(
                      children: [
                        Input(
                          title: "اختر اليوم",
                          type: "select",
                          value: d.day,
                          items: days
                              .map((day) => SelectItem(title: day, value: day))
                              .toList(),
                          onChanged: (v) {
                            setState(() {
                              groupDays[index].day = v.toString();
                            });
                          },
                        ),
                        Row(
                          spacing: 10,
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    showPicker(
                                      context: context,
                                      value: d.startTime,
                                      onChange: (v) {
                                        setState(
                                          () => groupDays[index].startTime = v,
                                        );
                                      },
                                    ),
                                  );
                                },
                                child: Text(
                                  "من: ${d.startTime.format(context)}",
                                  style: const TextStyle(fontSize: 13),
                                ),
                              ),
                            ),
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    showPicker(
                                      context: context,
                                      value: d.endTime,
                                      onChange: (v) {
                                        setState(
                                          () => groupDays[index].endTime = v,
                                        );
                                      },
                                    ),
                                  );
                                },
                                child: Text(
                                  "الى: ${d.endTime.format(context)}",
                                  style: const TextStyle(fontSize: 13),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    withDelete: groupDays.length > 1
                        ? IconButton(
                            icon: const Icon(
                              LucideIcons.trash,
                              color: Colors.red,
                              size: 20,
                            ),
                            onPressed: () {
                              setState(() {
                                groupDays.removeAt(index);
                              });
                            },
                          )
                        : null,
                  );
                }),
              ),

              if (groupDays.length < 6)
                TextButton(
                  onPressed: () {
                    setState(() {
                      _addNewDay();
                    });
                  },
                  child: const Text("إضافة يوم آخر"),
                ),

              _fildBuilder(
                "سعر الحصة",
                Input(
                  title: "سعر الحصة",
                  controller: c["price"]!,
                  type: "number",
                ),
              ),

              _fildBuilder(
                "درجة الحصة",
                Input(
                  title: "درجة الحصة",
                  controller: c["grade"]!,
                  type: "number",
                ),
              ),
              const SizedBox(height: 20),
              CustomButton(
                title: "حفظ المجموعة",
                onTap: () async {
                  if (c["price"]!.text.isEmpty) {
                    showMessage(
                      context,
                      "برجاء إدخال سعر الحصة",
                      isError: true,
                    );
                    return;
                  }

                  data.addGroup(
                    GroupsEntity(
                      timeGroups: groupDays,
                      price: double.parse(c["price"]!.text),
                      grade: double.parse(c["grade"]!.text),
                    ),
                  );

                  if (context.mounted) Navigator.pop(context);
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
