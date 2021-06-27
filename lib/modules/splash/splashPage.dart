import 'package:flutter/material.dart';
import 'package:payflow/shared/auth/authController.dart';
import 'package:payflow/shared/themes/appImages.dart';
import 'package:payflow/shared/themes/appcolors.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    final authController = AuthController();
    authController.currentUser(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(children: [
        Center(child: Image.asset(AppImages.union)),
        Center(child: Image.asset(AppImages.logoFull))
      ]),
    );
  }
}
