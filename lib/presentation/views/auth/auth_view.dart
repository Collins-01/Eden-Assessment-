import 'package:eden_demo/extensions/context_extension.dart';
import 'package:eden_demo/presentation/views/auth/viewmodels/auth_viewmodel.dart';
import 'package:eden_demo/presentation/widgets/widgets.dart';
import 'package:eden_demo/utils/utils.dart';
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
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap.h(context.deviceHeightPercentage(percentage: 9)),
                AppText.heading3("Hey there!, SignIn to continue..."),
                Gap.h(
                  context.deviceHeightPercentage(percentage: 30),
                ),
                AuthButton(
                  title: "Continue with Google",
                  callback: () => vm.signInWithGoogle(),
                ),
                Gap.h10,
                // AuthButton(
                //   title: "Continue with Github",
                //   callback: () => vm.signInWithGithub(),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
