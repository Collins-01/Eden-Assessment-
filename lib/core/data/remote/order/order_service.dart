import 'dart:async';

import 'package:eden_demo/core/data/data.dart';
import 'package:eden_demo/core/models/models.dart';
import 'package:faker/faker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

class OrderServiceImpl implements OrderService {
  final _uuid = const Uuid();
  final _faker = Faker();
  List<OrderModel> _list = [];
  Timer? _timer;
  final BehaviorSubject<List<OrderModel>> _ordersList =
      BehaviorSubject.seeded([]);
  OrderServiceImpl() {
    _list = [
      OrderModel(
        price: 10000.00,
        id: '1',
        orderType: OrderType.instant,
        timestamp: DateTime.now(),
        statusList: [
          OrderStatusModel(
            status: OrderStatus.ORDER_PLACED,
            timestamp: DateTime.now().add(
              const Duration(minutes: 5),
            ),
          )
        ],
        items: [
          ...List.generate(
            3,
            (index) => OrderItemModel(
              id: _uuid.v4(),
              name: _faker.food.dish(),
              price: 200,
              image: _faker.image.image(),
            ),
          )
        ],
      )
    ];
    _ordersList.sink.add(_list);
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      final currentOrders = _ordersList.value;
      final updatedOrders = currentOrders.map((order) {
        if (order.id == '1') {
          return OrderModel(
            id: order.id,
            orderType: order.orderType,
            timestamp: order.timestamp,
            items: order.items,
            statusList: order.statusList,
            price: order.price + 100,
          );
        } else {
          return order;
        }
      }).toList();
      _ordersList.add(updatedOrders);
    });
  }

  @override
  Stream<List<OrderModel>> get orders => _ordersList.asBroadcastStream();

  @override
  Future<void> updateOrder(String id) async {
    /// Look for the order by id
    /// implement the update activity
  }
}

final orderService = Provider<OrderService>((ref) {
  return OrderServiceImpl();
});
