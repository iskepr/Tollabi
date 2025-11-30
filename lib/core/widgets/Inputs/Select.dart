import 'package:flutter/material.dart';

class Select extends StatelessWidget {
  const Select({
    super.key,
    required this.decoration,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final String value;
  final List items;
  final Function(String?) onChanged;
  final InputDecoration decoration;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: decoration,
      initialValue: value,
      items: items
          .map<DropdownMenuItem<String>>(
            (i) => DropdownMenuItem<String>(value: i, child: Text(i)),
          )
          .toList(),
      onChanged: onChanged,
    );
  }
}
