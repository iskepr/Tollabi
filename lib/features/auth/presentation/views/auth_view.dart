import 'package:abo_sadah/features/auth/presentation/views/widgets/activ_acc.dart';
import 'package:abo_sadah/features/auth/presentation/views/widgets/login_view.dart';
import 'package:flutter/material.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key, this.isCode = false});

  final bool isCode;

  @override
  Widget build(BuildContext context) {
    if (isCode) return const ActivAcc();
    return const LoginView();
  }
}
