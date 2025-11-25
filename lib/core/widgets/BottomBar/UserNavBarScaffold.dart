import 'package:abo_sadah/core/widgets/BottomBar/BottomBar.dart';
import 'package:abo_sadah/core/widgets/BottomBar/NavBarEntity.dart';
import 'package:flutter/material.dart';

class UserNavBarScaffold extends StatefulWidget {
  const UserNavBarScaffold({super.key});

  @override
  State<UserNavBarScaffold> createState() => _UserNavBarScaffoldState();
}

class _UserNavBarScaffoldState extends State<UserNavBarScaffold> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: userNavBarItems[_currentIndex].widget,
        ),
      ),
      extendBody: true,
      bottomNavigationBar: BottomBar(
        selectedIndex: _currentIndex,
        pages: userNavBarItems,
        onChangePage: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
