import 'package:flutter/material.dart';
import 'package:abo_sadah/core/Theme/Colors.dart';

class MyBottomsheet extends StatefulWidget {
  const MyBottomsheet({super.key, required this.child, this.bg = true});

  final Widget child;
  final bool bg;

  @override
  State<MyBottomsheet> createState() => _MyBottomsheetState();
}

class _MyBottomsheetState extends State<MyBottomsheet> {
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
        padding: EdgeInsets.all(20),
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
              SizedBox(height: 10),
              widget.child,
            ],
          ),
        ),
      ),
    );
  }
}
