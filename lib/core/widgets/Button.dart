import 'package:abo_sadah/core/Theme/Colors.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.title,
    required this.onTap,
    this.icon,
    this.fontSize,
    this.padding,
  });

  final String title;
  final IconData? icon;
  final Function() onTap;

  final double? fontSize;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        decoration: BoxDecoration(
          color: ThemeColors.third,
          borderRadius: BorderRadius.circular(24),
        ),
        child: icon != null
            ? Icon(icon, color: ThemeColors.background)
            : Text(
                title,
                style: TextStyle(
                  color: ThemeColors.background,
                  fontSize: fontSize ?? 16,
                ),
              ),
      ),
    );
  }
}
