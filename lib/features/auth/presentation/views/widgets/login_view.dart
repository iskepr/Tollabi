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
                      Input(title: "الاسم بالكامل", controller: c["name"]),
                    Input(
                      title: "رقم الهاتف",
                      type: "number",
                      maxLength: 11,
                      controller: c["phone"],
                    ),
                    Input(title: "كلمة المرور", controller: c["pass"]),
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
                  final phone = c["phone"]!.text.trim();
                  final pass = c["pass"]!.text.trim();
                  final name = c["name"]!.text.trim();

                  if (phone.isEmpty ||
                      pass.isEmpty ||
                      (!isLogin && name.isEmpty)) {
                    showMessage(
                      context,
                      "برجاء ملء جميع الحقول",
                      isError: true,
                    );
                    return;
                  }

                  final prefs = await SharedPreferences.getInstance();
                  if (isLogin) {
                    final userData = prefs.getString("user_data");

                    if (userData != null) {
                      final data = jsonDecode(userData);
                      if (data["phone"] == phone && data["pass"] == pass) {
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
                          if (data["phone"] != phone) {
                            showMessage(
                              context,
                              "رقم الهاتف غير صحيح",
                              isError: true,
                            );
                            return;
                          }
                          if (data["pass"] != pass) {
                            showMessage(
                              context,
                              "كلمة المرور غير صحيحة",
                              isError: true,
                            );
                            return;
                          }
                        }
                      }
                    } else {
                      if (context.mounted) {
                        showMessage(
                          context,
                          "الحساب غير موجود، برجاء إنشاء حساب",
                          isError: true,
                        );
                      }
                    }
                  } else {
                    if (phone.length < 11) {
                      if (context.mounted) {
                        showMessage(
                          context,
                          "رقم الهاتف غير صحيح",
                          isError: true,
                        );
                      }
                      return;
                    }
                    try {
                      final code = phone
                          .substring(phone.length - 4)
                          .split("")
                          .reversed
                          .join("");

                      await prefs.setString(
                        'user_data',
                        jsonEncode({
                          "name": name,
                          "phone": phone,
                          "pass": pass,
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
                      debugPrint(e.toString());
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
