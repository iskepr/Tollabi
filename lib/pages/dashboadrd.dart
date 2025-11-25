import 'package:abo_sadah/core/Theme/Colors.dart';
import 'package:flutter/material.dart';

class Analysis extends StatelessWidget {
  Analysis({super.key});

  final List<Map<String, dynamic>> analysisData = [
    {"title": "المجموعات", "value": "20"},
    {"title": "الطلاب", "value": "50"},
    {"title": "الرئيسية", "value": "30"},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "مرحبا بك أبو سداح !",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: "VEXA",
          ),
        ),
        SizedBox(height: 20),
        Text("الإحصائيات", style: TextStyle(fontFamily: "VEXA", fontSize: 20)),

        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Wrap(
            children: List.generate(
              analysisData.length,
              (index) => AspectRatio(
                aspectRatio: 1,
                child: Container(
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: ThemeColors.forground,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(analysisData[index]["title"]),
                      Text(analysisData[index]["value"]),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
