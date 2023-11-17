import 'package:eden_demo/extensions/context_extension.dart';
import 'package:eden_demo/presentation/views/onboarding/viewmodels/splash_screen_viewmodel.dart';
import 'package:eden_demo/presentation/widgets/widgets.dart';
import 'package:eden_demo/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreenView extends ConsumerStatefulWidget {
  const SplashScreenView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SplashScreenViewState();
}

class _SplashScreenViewState extends ConsumerState<SplashScreenView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(splashScreenViewModelProvider).onModelReady();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SizedBox(
        height: context.getDeviceHeight,
        width: context.getDeviceWidth,
        child: Stack(
          alignment: Alignment.center,
          children: [
            AppText.heading4(
              "Eden Assessment",
              color: AppColors.whiteColor,
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 25,
              child: SizedBox(
                height: 40,
                width: 40,
                child: Center(
                  child: CircularProgressIndicator.adaptive(
                    backgroundColor: AppColors.whiteColor,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
