import 'dart:async';

import 'package:eden_demo/core/data/data.dart';
import 'package:eden_demo/core/models/models.dart';
import 'package:eden_demo/external_services/external_service.dart';
import 'package:eden_demo/utils/utils.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';

class OrderServiceImpl implements OrderService {
  final _logger = appLogger(OrderServiceImpl);
  // ignore: non_constant_identifier_names
  String ORDERS_CHANNEL = 'orders';
  // ignore: non_constant_identifier_names
  String NEW_STATUS = 'new_status';
  final AblyService ablyService;
  //This is used soley for the purpose of the updating aand tracking the current status of the order.
  final List<OrderStatus> _listOfStatus = [
    OrderStatus.ORDER_PLACED,
    OrderStatus.ORDER_ACCEPTED,
    OrderStatus.ORDER_PICKUP_IN_PROGRESS,
    OrderStatus.ORDER_ON_THE_WAY,
    OrderStatus.ORDER_ARRIVED,
    OrderStatus.ORDER_DELIVERED,
  ];
  int _currentStatusIndex = 0;
  bool _isConnected = false;
  final _faker = Faker();
  List<OrderModel> _list = [];
  Timer? _timer;
  final BehaviorSubject<List<OrderModel>> _ordersList =
      BehaviorSubject.seeded([]);
  OrderServiceImpl(this.ablyService) {
    _seedOrdersList();
    /*
    After `5` seconds of initializing the `OrderService`,a status update is sent to the server 
    to update the status of the order, since the is no backend to controller the activity yet.
    */
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      _currentStatusIndex = _currentStatusIndex + 1;
      _logger.d("_currentStatusIndex:: $_currentStatusIndex");
      final time = DateTime.now().add(const Duration(seconds: 3));
      //increase the status index

      await ablyService
          .channel(ORDERS_CHANNEL)
          .publish(name: NEW_STATUS, data: {
        'id': '2',
        'status': _listOfStatus[_currentStatusIndex].name,
        'timestamp': time.toString(),
      });
      if (_currentStatusIndex == _listOfStatus.length - 1) {
        _timer?.cancel();
      }
    });
    ablyService.connection.listen((event) {
      _logger.d("Connections Status ::: ${event.current.name}");
    });

    /// Listens for new order status, and updates the status on the list locally.
    ablyService
        .channel(ORDERS_CHANNEL)
        .subscribe(
          name: NEW_STATUS,
        )
        .listen(
      (message) {
        final data = message.data;
        _logger.d(data.runtimeType);

        _logger.d("Incoming Data from message $NEW_STATUS === $data");
        if (data != null) {
          final json = data as Map;
          final status = OrderStatusModel.statusFromString(json['status']);
          final id = json['id'];
          final timestamp = DateTime.parse(json['timestamp']);

          _listenAndUpdateStatus(id, status, timestamp);
        }
      },
    );
  }

  @override
  Stream<List<OrderModel>> get orders => _ordersList.asBroadcastStream();

  @override
  Stream<OrderModel?> watchOrder(String id) async* {
    final value = _ordersList.asyncMap((orders) async {
      var matchingItems = orders.where((element) => element.id == id).toList();
      return matchingItems.isNotEmpty ? matchingItems.first : null;
    });
    yield* value;
  }

  //********* PRIVATE METHODS ****************
  /// Listen to the orders list stream, and updates the status of an order
  void _listenAndUpdateStatus(
      String id, OrderStatus status, DateTime timestamp) {
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

      _logger.d("Stream list value: $list");
      _ordersList.add(list);
      _logger.d("list has been updated..");
    } else {
      _logger.d("Index does not exist");
    }
  }

  ///Seed Orders  List
  void _seedOrdersList() {
    _list = [
      OrderModel(
        price: 10000.00,
        deliveryFee: 800,
        packagingFee: 150,
        id: '2',
        orderType: OrderType.instant,
        timestamp: DateTime.now(),
        statusList: [
          OrderStatusModel(
            status: OrderStatus.ORDER_PLACED,
            timestamp: DateTime.now(),
          ),
          OrderStatusModel(
            status: OrderStatus.ORDER_ACCEPTED,
          ),
          OrderStatusModel(
            status: OrderStatus.ORDER_PICKUP_IN_PROGRESS,
          ),
          OrderStatusModel(
            status: OrderStatus.ORDER_ON_THE_WAY,
          ),
          OrderStatusModel(
            status: OrderStatus.ORDER_ARRIVED,
          ),
          OrderStatusModel(
            status: OrderStatus.ORDER_DELIVERED,
          ),
        ],
        items: [
          ...List.generate(
            7,
            (index) => OrderItemModel(
              id: _faker.guid.guid(),
              name: _faker.food.dish(),
              price: 300,
              image: _faker.image.image(),
            ),
          )
        ],
      ),
      OrderModel(
        price: 10000.00,
        deliveryFee: 800,
        packagingFee: 150,
        id: '3',
        orderType: OrderType.instant,
        timestamp: DateTime.now(),
        statusList: [
          OrderStatusModel(
            status: OrderStatus.ORDER_PLACED,
            timestamp: DateTime.now(),
          ),
          OrderStatusModel(
            status: OrderStatus.ORDER_ACCEPTED,
          ),
          OrderStatusModel(
            status: OrderStatus.ORDER_PICKUP_IN_PROGRESS,
          ),
          OrderStatusModel(
            status: OrderStatus.ORDER_ON_THE_WAY,
          ),
          OrderStatusModel(
            status: OrderStatus.ORDER_ARRIVED,
          ),
          OrderStatusModel(
            status: OrderStatus.ORDER_DELIVERED,
          ),
        ],
        items: [
          ...List.generate(
            3,
            (index) => OrderItemModel(
              id: _faker.guid.guid(),
              name: _faker.food.dish(),
              price: 200,
              image: _faker.image.image(),
            ),
          )
        ],
      ),
    ];
    _ordersList.sink.add(_list);
  }
}

final orderService = Provider<OrderService>((ref) {
  return OrderServiceImpl(ref.read(ablyServiceProvider));
});
