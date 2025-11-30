import 'package:abo_sadah/core/Theme/Colors.dart';
import 'package:abo_sadah/core/widgets/Inputs/Select.dart';
import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  Input({
    super.key,
    required this.title,
    required this.controller,
    this.value,
    this.prefixIcon,
    this.type = "text",
    this.style = "solid",

    this.items,
    this.onChanged,
  }) {
    if (value != null) {
      controller.text = value!;
    }
  }

  final String title;
  final TextEditingController controller;
  final String? value;
  final IconData? prefixIcon;
  final String? type;
  final String? style;

  final List? items;
  final Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    final decoration = InputDecoration(
      contentPadding: EdgeInsets.symmetric(horizontal: 10),
      prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
      hintText: title,
      enabledBorder: style == "border" ? null : InputBorder.none,
      focusedBorder: style == "border" ? null : InputBorder.none,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(17)),
    );

    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: style == "solid" ? ThemeColors.forground : Colors.transparent,
        borderRadius: BorderRadius.circular(17),
      ),
      child: type == "select"
          ? Select(
              items: items!,
              value: value!,
              onChanged: onChanged!,
              decoration: decoration,
            )
          : TextField(controller: controller, decoration: decoration),
    );
  }
}
