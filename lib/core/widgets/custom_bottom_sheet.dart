import 'package:flutter/material.dart';
import 'package:abo_sadah/core/Theme/Colors.dart';

class CustomBottomSheet extends StatefulWidget {
  const CustomBottomSheet({super.key, required this.child, this.bg = true});

  final Widget child;
  final bool bg;

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.7,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (_, controller) => Container(
        decoration: BoxDecoration(
          color: widget.bg ? ThemeColors.background : ThemeColors.forground,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        padding: EdgeInsets.only(top: 20, left: 10, right: 10),
        child: SingleChildScrollView(
          controller: controller,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: ThemeColors.forground,
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(30),
                    right: Radius.circular(30),
                  ),
                ),
                height: 5,
                width: 100,
              ),
              const SizedBox(height: 10),
              widget.child,
            ],
          ),
        ),
      ),
    );
  }
}
