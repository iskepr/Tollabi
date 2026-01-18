import 'dart:convert';

import 'package:tollabi/core/Theme/colors.dart';
import 'package:tollabi/core/data/all.dart';
import 'package:tollabi/core/functions/show_message.dart';
import 'package:tollabi/core/widgets/bottom_bar/user_nav_bar_scaffold.dart';
import 'package:tollabi/core/widgets/inputs/custom_button.dart';
import 'package:tollabi/core/widgets/inputs/input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isLogin = true;

  final Map<String, TextEditingController> c = {
    "name": TextEditingController(),
    "phone": TextEditingController(),
    "pass": TextEditingController(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Text(
                isLogin ? "تسجيل الدخول" : "إنشاء حساب",
                style: TextStyle(fontSize: 24),
              ),

              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: ThemeColors.secondary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    if (!isLogin)
                      Input(
                        title: "الاسم بالكامل",
                        style: "solid",
                        controller: c["name"],
                      ),
                    Input(
                      title: "رقم الهاتف",
                      style: "solid",
                      type: "number",
                      controller: c["phone"],
                    ),
                    Input(
                      title: "كلمة المرور",
                      style: "solid",
                      controller: c["pass"],
                    ),
                  ],
                ),
              ),
            ],
          ),

          Column(
            children: [
              CustomButton(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                title: isLogin ? "تسجيل الدخول" : "إنشاء حساب",
                onTap: () async {
                  final prefs = await SharedPreferences.getInstance();
                  if (isLogin) {
                    final userData = prefs.getString("user_data");

                    if (userData != null) {
                      final data = jsonDecode(userData);
                      if (data["phone"] == c["phone"]!.text.trim() &&
                          data["pass"] == c["pass"]!.text.trim()) {
                        await prefs.setString("app_status", "isLogin");

                        if (context.mounted) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const UserNavBarScaffold(),
                            ),
                          );
                        }
                      } else {
                        if (context.mounted) {
                          if (data["phone"] != c["phone"]!.text.trim()) {
                            showMessage(
                              context,
                              "رقم الهاتف غير صحيح",
                              isError: true,
                            );
                            return;
                          }
                          if (data["pass"] != c["pass"]!.text.trim()) {
                            showMessage(
                              context,
                              "كلمة المرور غير صحيحة",
                              isError: true,
                            );
                            return;
                          }
                        }
                      }
                    }
                  } else {
                    try {
                      final phone = c["phone"]!.text.trim();
                      final code = phone
                          .substring(phone.length - 4)
                          .split("")
                          .reversed
                          .join("");

                      await prefs.setString(
                        'user_data',
                        jsonEncode({
                          "name": c["name"]!.text.trim(),
                          "phone": c["phone"]!.text.trim(),
                          "pass": c["pass"]!.text.trim(),
                          "code": code,
                          "created_time": DateTime.now().toString(),
                        }),
                      );

                      await prefs.setString("app_status", "isLogin");

                      if (context.mounted) {
                        Provider.of<AppData>(context, listen: false).init();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const UserNavBarScaffold(),
                          ),
                        );
                      }
                    } catch (e) {
                      print(e);
                    }
                  }
                },
              ),
              TextButton(
                onPressed: () {
                  setState(() => isLogin = !isLogin);
                },
                child: Text(
                  isLogin
                      ? "ليس لديك حساب؟ إنشاء حساب"
                      : "لديك حساب؟ تسجيل الدخول",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
