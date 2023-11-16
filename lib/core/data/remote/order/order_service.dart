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
          //Start
          OrderStatusModel(
            status: OrderStatus.ORDER_PLACED,
            timestamp: DateTime.now(),

            //
          ),
          OrderStatusModel(
            status: OrderStatus.ORDER_ACCEPTED,
          ),
          OrderStatusModel(
            status: OrderStatus.ORDER_PICKUP_IN_PROGRESS,
          ),
          OrderStatusModel(
            status: OrderStatus.ORDER_DELIVERED,
          ),
          OrderStatusModel(
            status: OrderStatus.ORDER_DELIVERED,
          ),
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
    //
    // _initializeTimer();
    _timer = Timer.periodic(const Duration(seconds: 9), (timer) {
      _listenAndUpdateStatus('2', OrderStatus.ORDER_ACCEPTED);
    });
    ablyService.connection.listen((event) {
      _logger.d("Connections Status ::: ${event.current.name}");
    });
    ablyService.channel(ORDERS_CHANNEL).publish(
          // name: 'new_order',
          name: 'test',
          message: Message(
            // data: _list[0].toMap(),
            data: const {'message': "Testing ..."},
          ),
        );

    // ablyService.channel(ORDERS_CHANNEL).history();
    ablyService
        .channel(ORDERS_CHANNEL)
        .subscribe(
            // name: 'new_order',
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

  void _listenAndUpdateStatus(String id, OrderStatus status) {
    // Get the Order from the list
    //update the status
    //ad it bas to the orders stream list, at its index
    int index = _ordersList.value.indexWhere((order) => order.id == id);
    if (index != -1) {
      _logger.d("Index exists::: $index ");
      final order = _ordersList.value[index];
      final statuIndex =
          order.statusList.indexWhere((element) => element.status == status);
      _logger.d("Status Index: $statuIndex ");
      //
      final currentTime = DateTime.now().add(const Duration(minutes: 1));
      final initailStatuses = order.statusList;
      initailStatuses[statuIndex] =
          OrderStatusModel(status: status, timestamp: currentTime);
      // order.statusList.removeAt(statuIndex + 1);
      _timer?.cancel();
      final updatedOrder = order.copyWith(statusList: initailStatuses);
      _logger.d("updated status list == ${order.statusList.toList()}");
      final list = _ordersList.value;
      list[index] = updatedOrder;
      // list.insert(index, order);
      _logger.d("Stream list value: $list");
      _ordersList.add(list);
      _logger.d("list has been updated..");
    } else {
      _logger.d("Inex does not exist");
    }
  }

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
