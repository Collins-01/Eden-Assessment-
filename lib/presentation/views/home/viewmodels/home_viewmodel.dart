import 'package:eden_demo/core/domains/user_domain.dart';
import 'package:eden_demo/core/models/models.dart';
import 'package:eden_demo/presentation/states/states.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/data/remote/order/order.dart';

class HomeViewModel extends BaseViewModel {
  final Ref ref;
  HomeViewModel(this.ref);
  ValueNotifier<User?> get currentUser {
    return ref.read(userDomainProvider).currentUser;
  }

  Future<void> logOut() async {
    await ref.read(userDomainProvider).logOut();
  }

  Stream<List<OrderModel>> get ordersStream => ref.read(orderRepository).orders;

  final ordersStreamPprovider = StreamProvider<List<OrderModel>>((ref) async* {
    yield* ref.read(orderRepository).orders;
  });
}

final homeViewModelProvider = ChangeNotifierProvider<HomeViewModel>((ref) {
  return HomeViewModel(ref);
});
