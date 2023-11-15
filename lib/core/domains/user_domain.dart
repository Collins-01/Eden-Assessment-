import 'package:eden_demo/core/data/data.dart';
import 'package:eden_demo/core/models/models.dart';
import 'package:eden_demo/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserDomain {
  final Ref _ref;
  final _logger = appLogger(UserDomain);
  UserDomain(this._ref) {
    _init();
  }
  // final BehaviourSubject<User?> _currentUserSubject =
  //     BehaviourSubject.seeded(null);
  _init() async {
    final r = fb.FirebaseAuth.instance.authStateChanges();
    r.listen((event) {
      _logger.d("Current User Info == ${event?.photoURL}");
      if (event != null) {
        final u = User(
          id: event.uid,
          name: event.displayName!,
          email: event.email!,
          image: event.photoURL,
        );
        _currentUser.value = u;
      }
    });
  }

  logOut() async {
    _ref.read(authRepository).logOut();
    await Future.delayed(const Duration(milliseconds: 200));
    _currentUser.value = null;
  }

  final ValueNotifier<User?> _currentUser = ValueNotifier(null);
  ValueNotifier<User?> get currentUser => _currentUser;
}

final userDomainProvider = Provider<UserDomain>((ref) {
  return UserDomain(ref);
});
