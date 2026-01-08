import 'dart:io';

import 'package:abo_sadah/core/data/all.dart';
import 'package:abo_sadah/core/Theme/colors.dart';
import 'package:abo_sadah/core/data/sqflite/sql.dart';
import 'package:abo_sadah/core/widgets/bottom_bar/user_nav_bar_scaffold.dart';
import 'package:abo_sadah/features/auth/presentation/views/auth_view.dart';
import 'package:abo_sadah/generated/l10n.dart' show S;
import 'package:abo_sadah/features/splash/presentation/views/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:abo_sadah/core/data/sqflite/tabels.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  await MySqfLite.init('abo_sadah.db');
  await createTables();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppData(),
      builder: (context, child) {
        final appStatus = Provider.of<AppData>(context).appStatus;
        final createdTime = Provider.of<AppData>(context).userData.createdTime;
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
          home: appStatus == "isFirstTime"
              ? const Splash()
              : appStatus == "isLogout"
              ? const AuthView()
              : ((DateTime.now().difference(createdTime).inDays > 3) ||
                        appStatus == "isNeedCode") &&
                    appStatus != "isActive"
              ? const AuthView(isCode: true)
              : const UserNavBarScaffold(),
        );
      },
    );
  }
}
