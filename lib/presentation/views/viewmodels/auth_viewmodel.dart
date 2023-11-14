import 'package:eden_demo/presentation/states/states.dart';
import 'package:eden_demo/router/router.dart';
import 'package:eden_demo/utils/utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthViewModel extends BaseViewModel {
  final _logger = appLogger(AuthViewModel);
  final Ref ref;
  AuthViewModel(this.ref);

  signInWithGoogle() async {
    try {
      changeState(const ViewModelState.busy());
      await Future.delayed(const Duration(seconds: 3));
      changeState(const ViewModelState.idle());
      NavigationService.instance.navigateTo(RoutePaths.homeView);
    } catch (e) {
      _logger.e("Google SignIn Error : $e");
    }
  }
}

final authViewModelProvider = ChangeNotifierProvider<AuthViewModel>((ref) {
  return AuthViewModel(ref);
});
