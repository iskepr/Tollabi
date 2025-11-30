import 'package:abo_sadah/core/Data/all.dart';
import 'package:abo_sadah/core/Theme/Colors.dart';
import 'package:flutter/material.dart';

class Analysis extends StatelessWidget {
  Analysis({super.key});

  final List<Map<String, dynamic>> analysisData = AppData.analysisData;

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
          child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              childAspectRatio: 1,
              mainAxisExtent: 100,
            ),
            itemCount: analysisData.length,
            itemBuilder: (context, index) => Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: ThemeColors.forground,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    analysisData[index]["title"],
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    analysisData[index]["value"],
                    style: TextStyle(fontWeight: FontWeight.bold),
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
