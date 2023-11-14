import 'package:eden_demo/core/models/models.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';

class UserDomain {
  UserDomain() {
    _init();
  }
  _init() async {
    final r = fb.FirebaseAuth.instance.authStateChanges();
    r.listen((event) {
      if (event != null) {
        final u = User(
            id: event.uid, name: event.displayName ?? "", email: event.email!);
        _currentUserSubject.sink.add(u);
      }
    });
  }

  final BehaviorSubject<User?> _currentUserSubject =
      BehaviorSubject.seeded(null);
  Stream<User?> get currentUserStream =>
      _currentUserSubject.asBroadcastStream();
}

final userDomainProvider = Provider<UserDomain>((ref) {
  return UserDomain();
});
