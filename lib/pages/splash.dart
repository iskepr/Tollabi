import 'package:abo_sadah/core/widgets/BottomBar/UserNavBarScaffold.dart';
import 'package:flutter/material.dart';
import 'package:abo_sadah/core/widgets/Button.dart';
import 'package:abo_sadah/core/Theme/Colors.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.secondary,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Stack(
          children: [
            Column(
              children: [
                Positioned(
                  child: Expanded(
                    child: Image.asset("assets/imgs/spalshMen.png"),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: ThemeColors.background,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.elliptical(200, 100),
                        topRight: Radius.elliptical(200, 100),
                      ),
                    ),
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(height: 20),

                        Text(
                          "مرحبا بك أبو سداح !",
                          style: TextStyle(
                            fontSize: 24,
                            fontFamily: "VEXA",
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text(
                          "هذا هو مركز إدارتك الذكية للدروس\nالخصوصية. نظّم حصصك، وتابع طلابك،\nورتّب مواعيدك بكل سهولة، لتتفرّغ\nلما يهم حقًا: التدريس وصناعة أثر أكبر.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: "VEXA",
                            fontWeight: FontWeight.w100,
                          ),
                        ),

                        Button(
                          title: "ابدا الان",
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => UserNavBarScaffold()),
                            );
                          },
                        ),

                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Center(child: Image.asset("assets/imgs/logo.png")),
          ],
        ),
      ),
    );
  }
}
