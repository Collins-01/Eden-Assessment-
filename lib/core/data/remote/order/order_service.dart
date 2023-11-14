import 'package:eden_demo/core/data/data.dart';
import 'package:eden_demo/core/models/data_models/order_model.dart';
import 'package:rxdart/rxdart.dart';

class OrderServiceImpl implements OrderService {
  final BehaviorSubject<List<OrderModel>> _ordersList =
      BehaviorSubject.seeded([]);
  @override
  Stream<List<OrderModel>> get orders => _ordersList.asBroadcastStream();

  @override
  Future<void> updateOrder(String id) async {
    /// Look for the order by id
    /// implement the update activity
  }
}
