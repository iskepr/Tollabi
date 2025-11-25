import 'package:abo_sadah/core/Theme/Colors.dart';
import 'package:abo_sadah/generated/l10n.dart' show S;
import 'package:abo_sadah/pages/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: Locale("ar"),
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      debugShowCheckedModeBanner: false,
      title: 'ابو سداح',
      theme: ThemeData(
        fontFamily: "Tajawal",
        colorScheme: ColorScheme.fromSeed(seedColor: ThemeColors.primary),
        scaffoldBackgroundColor: ThemeColors.background,
      ),
      home: const Splash(),
    );
  }
}
