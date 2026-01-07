import 'package:abo_sadah/core/constants/assets.dart';
import 'package:abo_sadah/features/splash/presentation/views/widgets/login_view.dart';
import 'package:flutter/material.dart';
import 'package:abo_sadah/core/widgets/inputs/custom_button.dart';
import 'package:abo_sadah/core/Theme/colors.dart';

class SplashBody extends StatelessWidget {
  const SplashBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.secondary,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(child: Image.asset(Assets.assetsImgsSpalshMen)),
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
                        const SizedBox(height: 20),

                        const Text(
                          "مرحبا بك أبو سداح !",
                          style: TextStyle(
                            fontSize: 24,
                            fontFamily: "VEXA",
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const Text(
                          "هذا هو مركز إدارتك الذكية للدروس\nالخصوصية. نظّم حصصك، وتابع طلابك،\nورتّب مواعيدك بكل سهولة، لتتفرّغ\nلما يهم حقًا: التدريس وصناعة أثر أكبر.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: "VEXA",
                            fontWeight: FontWeight.w100,
                          ),
                        ),

                        CustomButton(
                          title: "ابدا الان",
                          onTap: () async {
                            if (context.mounted) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginView(),
                                ),
                              );
                            }
                          },
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Center(child: Image.asset(Assets.assetsImgsLogo)),
          ],
        ),
      ),
    );
  }
}
