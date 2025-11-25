import 'package:abo_sadah/core/Theme/Colors.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.title,
    required this.onTap,
    this.icon,
    this.fontSize,
  });

  final String title;
  final IconData? icon;
  final Function() onTap;

  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onTap,
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
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
