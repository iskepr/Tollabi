import 'package:abo_sadah/core/Theme/Colors.dart';
import 'package:abo_sadah/core/widgets/BottomBar/NavBarEntity.dart';
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
    final width = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.symmetric(horizontal: width * 0.1, vertical: 20),
      height: MediaQuery.of(context).size.height * 0.1,
      decoration: BoxDecoration(
        color: ThemeColors.primary,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          widget.pages.length,
          (index) => GestureDetector(
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
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                  )
                else
                  SizedBox(width: 32, height: 2),

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
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),

                SizedBox(),
              ],
            ),
          ),
        ).toList(),
      ),
    );
  }
}
