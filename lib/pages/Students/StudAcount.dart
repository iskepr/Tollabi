import 'package:abo_sadah/core/Theme/Colors.dart';
import 'package:abo_sadah/core/widgets/Button.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class StudAcount extends StatefulWidget {
  StudAcount({super.key, required this.userData});

  final Map<String, dynamic> userData;

  @override
  State<StudAcount> createState() => _StudAcountState();
}

class _StudAcountState extends State<StudAcount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("حساب الطلاب", style: TextStyle(fontSize: 20)),
                Button(
                  title: "الرجوع",
                  icon: LucideIcons.chevronRight,
                  fontSize: 12,
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: ThemeColors.forground),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(widget.userData["img"]),
                    maxRadius: 24,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(widget.userData["name"]),
                      Text(widget.userData["phone"]),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
