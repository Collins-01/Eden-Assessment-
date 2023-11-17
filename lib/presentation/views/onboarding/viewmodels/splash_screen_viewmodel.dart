import 'package:eden_demo/external_services/external_service.dart';
import 'package:eden_demo/presentation/states/states.dart';
import 'package:eden_demo/router/router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreenViewModel extends BaseViewModel {
  final Ref ref;
  SplashScreenViewModel(this.ref);
  onModelReady() async {
    ref.read(ablyServiceProvider).init();
    await Future.delayed(const Duration(seconds: 2));
    NavigationService.instance.navigateToReplaceAll(RoutePaths.appWrapperView);
  }
}

final splashScreenViewModelProvider =
    ChangeNotifierProvider<SplashScreenViewModel>((ref) {
  return SplashScreenViewModel(ref);
});
