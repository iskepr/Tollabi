import 'package:flutter/material.dart';
import 'package:abo_sadah/core/Theme/Colors.dart';

void showMessage(BuildContext context, String msg, {bool isError = false}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(msg),
      backgroundColor: isError ? ThemeColors.error : ThemeColors.third,
    ),
  );
}
