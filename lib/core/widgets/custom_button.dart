import 'package:abo_sadah/core/Theme/Colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title,
    required this.onTap,
    this.icon,
    this.fontSize,
    this.padding,
    this.radius,
    this.disabled = false,
    this.active = true,
  });

  final String title;
  final IconData? icon;
  final Function() onTap;

  final double? fontSize;
  final EdgeInsets? padding;
  final double? radius;
  final bool disabled;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: disabled ? null : onTap,
      child: Container(
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        decoration: BoxDecoration(
          color: disabled || !active
              ? ThemeColors.secondary
              : ThemeColors.third,
          borderRadius: BorderRadius.circular(radius ?? 24),
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
