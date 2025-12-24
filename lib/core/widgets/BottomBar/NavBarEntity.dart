import 'package:abo_sadah/features/expenses/presentation/views/expenses_view.dart';
import 'package:abo_sadah/features/groups/presentation/views/groups_view.dart';
import 'package:abo_sadah/features/dashboard/presentation/views/dash_view.dart';
import 'package:abo_sadah/features/students/presentation/views/students_view.dart';
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
    widget: DashView(),
  ),
  NavBarEntity(
    title: 'حضور الطلاب',
    icon: LucideIcons.graduationCap300,
    widget: StudentsView(),
  ),
  NavBarEntity(
    title: 'الطلاب',
    icon: LucideIcons.user300,
    widget: StudentsView(),
  ),
  NavBarEntity(
    title: 'المصروفات',
    icon: LucideIcons.walletCards300,
    widget: ExpensesView(),
  ),
  NavBarEntity(
    title: 'المجموعات',
    icon: LucideIcons.users300,
    widget: GroupsView(),
  ),
];
