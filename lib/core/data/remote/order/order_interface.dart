import 'package:eden_demo/core/models/models.dart';

abstract class OrderInterface {
  /// Get all orders as a stream
  Stream<List<OrderModel>> get orders;

  /// Update an order by its ID
  Future<void> updateOrder(String id);
}

abstract class OrderService implements OrderInterface {}

abstract class OrderRepository implements OrderInterface {}
