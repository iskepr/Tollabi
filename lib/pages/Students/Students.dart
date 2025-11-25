import 'package:abo_sadah/core/Theme/Colors.dart';
import 'package:abo_sadah/core/constants/assets.dart';
import 'package:abo_sadah/core/widgets/Button.dart';
import 'package:abo_sadah/core/widgets/Input.dart';
import 'package:abo_sadah/core/widgets/Students/addStud.dart';
import 'package:abo_sadah/pages/Students/StudAcount.dart';
import 'package:flutter/material.dart';

class Students extends StatefulWidget {
  const Students({super.key});

  @override
  State<Students> createState() => _StudentsState();
}

class _StudentsState extends State<Students> {
  List<Map<String, dynamic>> students = [
    {
      "id": 1,
      "name": "احمد علي خالد",
      "phone": "+20 0109876543",
      "img": Assets.assetsImgsBoy,
    },
    {
      "id": 2,
      "name": "محمد محمد محمد",
      "phone": "+20 0109876543",
      "img": Assets.assetsImgsBoy,
    },
    {
      "id": 3,
      "name": "احمد علي خالد",
      "phone": "+20 0109876543",
      "img": Assets.assetsImgsBoy,
    },
    {
      "id": 4,
      "name": "محمد محمد محمد",
      "phone": "+20 0109876543",
      "img": Assets.assetsImgsBoy,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("كل الطلاب", style: TextStyle(fontSize: 20)),
            Button(
              title: "+ اضافة صالب",
              fontSize: 12,
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
          controller: TextEditingController(),
        ),
        SizedBox(height: 10),
        GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 198 / 80,
            mainAxisExtent: 70,
          ),
          itemCount: students.length,
          itemBuilder: (BuildContext context, int index) => GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StudAcount(userData: students[index]),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: ThemeColors.forground,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(students[index]["img"]),
                    maxRadius: 24,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(students[index]["name"]),
                      Text(students[index]["phone"]),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
