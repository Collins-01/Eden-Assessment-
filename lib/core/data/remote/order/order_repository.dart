import 'package:eden_demo/core/data/data.dart';
import 'package:eden_demo/core/models/data_models/order_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderService orderService;
  OrderRepositoryImpl(this.orderService);

  @override
  Stream<List<OrderModel>> get orders => orderService.orders;

  @override
  Future<void> updateOrder(String id) async {
    return await orderService.updateOrder(id);
  }

  @override
  Stream<OrderModel?> watchOrder(String id) async* {
    yield* orderService.watchOrder(id);
  }
}

final orderRepository = Provider<OrderRepository>((ref) {
  return OrderRepositoryImpl(
    ref.read(orderService),
  );
});
