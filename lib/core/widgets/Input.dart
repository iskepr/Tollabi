import 'package:abo_sadah/core/Theme/Colors.dart';
import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  const Input({
    super.key,
    required this.title,
    required this.controller,
    this.prefixIcon,
    this.style = "solid",
  });
  final String title;
  final TextEditingController controller;
  final IconData? prefixIcon;
  final String? style;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: style == "solid" ? ThemeColors.forground : Colors.transparent,
        borderRadius: BorderRadius.circular(17),
      ),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          hintText: title,
          enabledBorder: style == "border" ? null : InputBorder.none,
          focusedBorder: style == "border" ? null : InputBorder.none,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(17)),
        ),
      ),
    );
  }
}
