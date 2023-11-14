import 'package:eden_demo/core/models/response_models/response_models.dart';

abstract class AuthInterface {
  Future<GoogleSignInResponseModel> signInWithGoogle();
  Future<void> logOut();
  Future<GithubSignInResponseModel> signInWithGithub();
}

abstract class AuthService implements AuthInterface {}

abstract class AuthRepository implements AuthInterface {}
