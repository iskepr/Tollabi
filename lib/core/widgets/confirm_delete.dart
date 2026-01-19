import 'package:flutter/material.dart';
import 'package:tollabi/core/widgets/custom_bottom_sheet.dart';
import 'package:tollabi/core/widgets/inputs/custom_button.dart';

class ConfirmDelete extends StatelessWidget {
  const ConfirmDelete({
    super.key,
    required this.title,
    required this.onConfirm,
  });
  final String title;
  final Function() onConfirm;

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheet(
      child: Column(
        children: [
          Text(
            "هل انت متاكد من حذف $title؟",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),

          CustomButton(title: "حذف $title", onTap: onConfirm),
        ],
      ),
    );
  }
}
