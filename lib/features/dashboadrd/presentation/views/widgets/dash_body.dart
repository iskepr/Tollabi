import 'package:abo_sadah/core/Theme/Colors.dart';
import 'package:abo_sadah/core/data/all.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashBody extends StatelessWidget {
  const DashBody({super.key});

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
          child: Consumer<AppData>(
            builder: (context, data, child) => GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                childAspectRatio: 1,
                mainAxisExtent: 100,
              ),
              itemCount: data.analysisData.length,
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
                      data.analysisData[index].title,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      data.analysisData[index].value.toString(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
