import 'package:abo_sadah/core/Theme/colors.dart';
import 'package:abo_sadah/core/widgets/bottom_bar/nav_bar_entity.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({
    super.key,
    required this.pages,
    required this.selectedIndex,
    required this.onChangePage,
  });

  final List<NavBarEntity> pages;
  final int selectedIndex;
  final Function(int)? onChangePage;

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.only(right: 10, left: 10, bottom: 10),
      height: 65,
      decoration: BoxDecoration(
        color: ThemeColors.primary,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          widget.pages.length,
          (index) => GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              setState(() {
                selectedIndex = index;
                widget.onChangePage!(index);
              });
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (selectedIndex == index)
                  Container(
                    width: 32,
                    height: 2,
                    decoration: BoxDecoration(
                      color: ThemeColors.fourth,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: ThemeColors.fourth,
                          blurRadius: 10,
                          spreadRadius: 2,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                  )
                else
                  const SizedBox(width: 32, height: 2),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      widget.pages[index].icon,
                      color: ThemeColors.background,
                      size: 20,
                    ),
                    Text(
                      widget.pages[index].title,
                      style: TextStyle(
                        color: ThemeColors.background,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),

                const SizedBox(),
              ],
            ),
          ),
        ).toList(),
      ),
    );
  }
}
