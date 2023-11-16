import 'dart:async';

import 'package:ably_flutter/ably_flutter.dart';
import 'package:eden_demo/core/data/data.dart';
import 'package:eden_demo/core/models/models.dart';
import 'package:eden_demo/external_services/external_service.dart';
import 'package:eden_demo/utils/utils.dart';
import 'package:faker/faker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

class OrderServiceImpl implements OrderService {
  final _logger = appLogger(OrderServiceImpl);
  // ignore: non_constant_identifier_names
  String ORDERS_CHANNEL = 'orders';
  final AblyService ablyService;
  final _uuid = const Uuid();
  final _faker = Faker();
  List<OrderModel> _list = [];
  Timer? _timer;
  final BehaviorSubject<List<OrderModel>> _ordersList =
      BehaviorSubject.seeded([]);
  OrderServiceImpl(this.ablyService) {
    /// Initialize the ably service
    ablyService.init();
    _list = [
      OrderModel(
        price: 10000.00,
        id: '2',
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
    ablyService.connection.listen((event) {
      _logger.d("Connecttion Status ::: ${event.current.name}");
    });
    ablyService.channel(ORDERS_CHANNEL).publish(
          name: 'new_order',
          message: Message(
            data: _list[0].toMap(),
          ),
        );

    // ablyService.channel(ORDERS_CHANNEL).history();
    ablyService
        .channel(ORDERS_CHANNEL)
        .subscribe(
          name: 'new_order',
          // names: [],
        )
        .listen(
      (event) {
        _logger.d("New Data::: ${event.data}");
        _logger.d("New Name::: ${event.name}");
      },
    );
    ablyService
        .channel(ORDERS_CHANNEL)
        .presence
        .subscribe(action: PresenceAction.enter)
        .listen((event) {
      _logger.d("Presence Action Data::::: ${event.data} ");
    });
  }

  Future _seed() async {}

  @override
  Stream<List<OrderModel>> get orders => _ordersList.asBroadcastStream();

  @override
  Future<void> updateOrder(String id) async {
    /// Look for the order by id
    /// implement the update activity
  }

  @override
  Stream<OrderModel?> watchOrder(String id) async* {
    final value = _ordersList.asyncMap((orders) async {
      var matchingItems = orders.where((element) => element.id == id).toList();
      return matchingItems.isNotEmpty ? matchingItems.first : null;
    });
    yield* value;
  }
}

final orderService = Provider<OrderService>((ref) {
  return OrderServiceImpl(ref.read(ablyServiceProvider));
});
