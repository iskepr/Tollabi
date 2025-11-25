import 'package:abo_sadah/pages/dashboadrd.dart';
import 'package:abo_sadah/pages/Students/Students.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class NavBarEntity {
  final String title;
  final IconData icon;
  final Widget widget;

  NavBarEntity({required this.title, required this.icon, required this.widget});
}

List<NavBarEntity> userNavBarItems = [
  NavBarEntity(
    title: 'الرئيسية',
    icon: LucideIcons.house300,
    widget: Analysis(),
  ),
  NavBarEntity(
    title: 'الطلاب',
    icon: LucideIcons.notepadText300,
    widget: Students(),
  ),
  NavBarEntity(
    title: 'المجموعات',
    icon: LucideIcons.users300,
    widget: Text("shiii"),
  ),
];
