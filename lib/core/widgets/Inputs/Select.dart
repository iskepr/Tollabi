import 'package:flutter/material.dart';

class Select extends StatelessWidget {
  const Select({
    super.key,
    required this.decoration,
    required this.title,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final String title;
  final String? value;
  final List<SelectItem> items;
  final Function(String?) onChanged;
  final InputDecoration decoration;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: decoration,
      initialValue: value,
      items: items
          .map<DropdownMenuItem<String>>(
            (i) =>
                DropdownMenuItem<String>(value: i.value, child: Text(i.title)),
          )
          .toList(),
      onChanged: onChanged,
    );
  }
}

class SelectItem {
  final String title;
  final String value;
  SelectItem({required this.title, required this.value});
}
