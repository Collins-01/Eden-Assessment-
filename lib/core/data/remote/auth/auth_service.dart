import 'package:eden_demo/core/data/data.dart';
import 'package:eden_demo/core/errors/errors.dart';
import 'package:eden_demo/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:eden_demo/core/models/response_models/github_sign_in_response_model.dart';
import 'package:eden_demo/core/models/response_models/google_sign_in_response_model.dart';

class AuthServiceImpl implements AuthService {
  final _logger = appLogger(AuthServiceImpl);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  @override
  Future<void> logOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  @override
  Future<GithubSignInResponseModel> signInWithGithub() {
    // TODO: implement signInWithGithub
    throw UnimplementedError();
  }

  @override
  Future<GoogleSignInResponseModel> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      final response = await _auth.signInWithCredential(credential);
      _logger.d(
          "Google SignIn Response::: ${response.user?.email}|| ${response.user?.displayName}");
      return GoogleSignInResponseModel();
    } catch (e) {
      _logger.e("Error Signing in with Google ::: ${e.toString()}");
      throw CustomError('Unknown Error', e.toString());
    }
  }
}

final authService = Provider<AuthService>((ref) {
  return AuthServiceImpl();
});
