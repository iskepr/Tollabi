import 'package:abo_sadah/core/data/all.dart';
import 'package:abo_sadah/core/functions/show_message.dart';
import 'package:abo_sadah/core/widgets/bottom_bar/user_nav_bar_scaffold.dart';
import 'package:abo_sadah/core/widgets/inputs/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActivAcc extends StatelessWidget {
  const ActivAcc({super.key});

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<AppData>(context);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          right: 20,
          left: 20,
          bottom: MediaQuery.of(context).size.height * 0.5,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              "انتهت الفترة التجريبية يرجى التواصل معنا لتفعيل الحساب",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24),
            ),
            Directionality(
              textDirection: TextDirection.ltr,
              child: OtpTextField(
                numberOfFields: 4,
                borderColor: Color(0xFF512DA8),
                showFieldAsBox: true,
                onSubmit: (String verificationCode) async {
                  final prefs = await SharedPreferences.getInstance();
                  if (data.userData.code == verificationCode) {
                    await prefs.setString("app_status", "isActive");
                    if (context.mounted) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const UserNavBarScaffold(),
                        ),
                      );
                      showMessage(context, "تم تفعيل الحساب بنجاح");
                    }
                  } else {
                    if (context.mounted) {
                      showMessage(context, "الكود غير صحيح", isError: true);
                    }
                  }
                },
              ),
            ),

            CustomButton(
              title: "تواصل معنا عبر الواتساب",
              onTap: () async {
                final Uri url = Uri.parse('https://wa.me/201551450098');
                if (!await launchUrl(url)) {
                  throw Exception('Could not launch $url');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
