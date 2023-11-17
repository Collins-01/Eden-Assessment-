import 'package:eden_demo/presentation/widgets/widgets.dart';
import 'package:eden_demo/router/router.dart';
import 'package:eden_demo/utils/utils.dart';
import 'package:flutter/material.dart';

class AppSnackBar {
  static void showErrorSnackbar(String message) {
    final scaffold = ScaffoldMessenger.of(
        NavigationService.instance.navigatorKey.currentContext!);
    scaffold.showSnackBar(
      SnackBar(
        backgroundColor: AppColors.errorColor,
        content: AppText.body1(
          message,
          color: AppColors.whiteColor,
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
