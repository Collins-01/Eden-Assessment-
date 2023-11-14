import 'package:eden_demo/core/data/data.dart';
import 'package:eden_demo/core/models/response_models/github_sign_in_response_model.dart';
import 'package:eden_demo/core/models/response_models/google_sign_in_response_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService _authService;
  AuthRepositoryImpl(this._authService);
  @override
  Future<void> logOut() {
    // TODO: implement logOut
    throw UnimplementedError();
  }

  @override
  Future<GithubSignInResponseModel> signInWithGithub() {
    // TODO: implement signInWithGithub
    throw UnimplementedError();
  }

  @override
  Future<GoogleSignInResponseModel> signInWithGoogle() async {
    return await _authService.signInWithGoogle();
  }
}

final authRepository = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    ref.read(authService),
  );
});
