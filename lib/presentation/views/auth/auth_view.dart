import 'package:eden_demo/presentation/views/auth/viewmodels/auth_viewmodel.dart';
import 'package:eden_demo/presentation/widgets/widgets.dart';
import 'package:eden_demo/utils/sizing_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthView extends ConsumerWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(authViewModelProvider);
    return LoaderPage(
      isBusy: vm.isBusy,
      child: Scaffold(
        body: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: SizingConfig.defaultPadding),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AuthButton(
                  title: "Continue with Google",
                  callback: () => vm.signInWithGoogle(),
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
      ),
    );
  }
}
