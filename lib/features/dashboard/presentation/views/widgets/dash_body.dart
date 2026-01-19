import 'package:tollabi/core/Theme/colors.dart';
import 'package:tollabi/core/data/all.dart';
import 'package:tollabi/core/utils/format.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashBody extends StatefulWidget {
  const DashBody({super.key});

  @override
  State<DashBody> createState() => _DashBodyState();
}

class _DashBodyState extends State<DashBody> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<AppData>(context, listen: false);

    return Column(
      children: [
        Text(
          "مرحبا بك ${data.userData.name.split(" ")[0]} !",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: "VEXA",
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          "الإحصائيات",
          style: TextStyle(fontFamily: "VEXA", fontSize: 20),
        ),

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
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: ThemeColors.forground,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      data.analysisData[index].title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                        fontFamily: "Tajawal",
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      formatDouble(data.analysisData[index].value.toDouble()),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: ThemeColors.primary,
                      ),
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
