import 'package:flutter/material.dart';

class CustomGrid extends StatelessWidget {
  const CustomGrid({
    super.key,
    required this.child,
    required this.count,
    required this.emptyText,
  });

  final Widget Function(BuildContext, int) child;
  final int count;
  final String emptyText;

  @override
  Widget build(BuildContext context) {
    if (count == 0) {
      return Text(emptyText);
    }
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 198 / 80,
        mainAxisExtent: 70,
      ),
      itemCount: count,
      itemBuilder: child,
    );
  }
}
