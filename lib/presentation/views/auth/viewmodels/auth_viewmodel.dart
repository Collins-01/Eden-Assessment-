import 'package:eden_demo/core/data/data.dart';
import 'package:eden_demo/core/errors/errors.dart';
import 'package:eden_demo/presentation/states/states.dart';
import 'package:eden_demo/presentation/widgets/widgets.dart';
import 'package:eden_demo/router/router.dart';
import 'package:eden_demo/utils/utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthViewModel extends BaseViewModel {
  final _logger = appLogger(AuthViewModel);
  final Ref ref;
  AuthViewModel(this.ref);

  Future<void> signInWithGoogle() async {
    try {
      changeState(const ViewModelState.busy());
      final result = await ref.read(authRepository).signInWithGoogle();
      changeState(const ViewModelState.idle());
      NavigationService.instance.navigateTo(RoutePaths.homeView);
    } on Failure catch (e) {
      _logger.e("error from google sign in :: ${e.message}");
      AppSnackBar.showErrorSnackbar(e.message);
    } catch (e) {
      _logger.e("Google SignIn Error : $e");
      AppSnackBar.showErrorSnackbar(e.toString());
    }
  }

  Future<void> signInWithGithub() async {
    try {
      changeState(const ViewModelState.busy());
      final result = await ref.read(authRepository).signInWithGithub();
      changeState(const ViewModelState.idle());
      NavigationService.instance.navigateTo(RoutePaths.homeView);
    } on Failure catch (e) {
      _logger.e("error from github sign in :: ${e.message}");
      AppSnackBar.showErrorSnackbar(e.message);
    } catch (e) {
      _logger.e("Github SignIn Error : $e");
      AppSnackBar.showErrorSnackbar(e.toString());
    }
  }
}

final authViewModelProvider = ChangeNotifierProvider<AuthViewModel>((ref) {
  return AuthViewModel(ref);
});
