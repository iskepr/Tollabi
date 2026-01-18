import 'package:tollabi/core/Theme/colors.dart';
import 'package:flutter/material.dart';

abstract class TextStyles {
  static const String fontFamily = "Cairo";
  static const String fontFamily2 = "VEXA";

  static const TextStyle trailing = TextStyle(
    fontSize: 14,
    color: ThemeColors.third,
  );

  static const TextStyle title = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: ThemeColors.black,
  );
}
