import 'package:eden_demo/extensions/extensions.dart';
import 'package:eden_demo/presentation/widgets/widgets.dart';
import 'package:eden_demo/utils/app_colors.dart';
import 'package:eden_demo/utils/sizing_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthView extends ConsumerWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizingConfig.defaultPadding),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AuthButton(
                title: "Continue with Google",
                callback: () => print("object"),
              ),
              Gap.h10,
              AuthButton(
                title: "Continue with Github",
                callback: () => print("object"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
