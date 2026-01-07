import 'package:abo_sadah/core/Theme/Colors.dart';
import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  const CustomCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final String value;
  final Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 20,
        height: 20,
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: value == "true" ? ThemeColors.fourth : Colors.transparent,
          border: Border.all(
            color: value == "true" ? ThemeColors.fourth : ThemeColors.secondary,
          ),
          borderRadius: BorderRadius.circular(7),
        ),
        alignment: Alignment.center,
        child: Text(
          value == "true"
              ? "✓"
              : value == "null"
              ? ""
              : value,
          style: TextStyle(
            fontSize: 12,
            color: value == "true"
                ? ThemeColors.background
                : ThemeColors.secondary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      onTap: () => onChanged(value == "true" ? null : "true"),
    );
  }
}
