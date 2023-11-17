import 'package:eden_demo/core/models/models.dart';

abstract class OrderInterface {
  /// Get all orders as a stream
  Stream<List<OrderModel>> get orders;

  /// Watch an order by its id
  Stream<OrderModel?> watchOrder(String id);
}

abstract class OrderService implements OrderInterface {}

abstract class OrderRepository implements OrderInterface {}
