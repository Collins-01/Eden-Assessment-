// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:eden_demo/core/models/data_models/order_item_model.dart';
import 'package:eden_demo/core/models/data_models/order_status_model.dart';

enum OrderType { instant, delayed }

extension OrderTypeExtension on OrderType {
  bool get isInstant => this == OrderType.instant;
  bool get isDelayed => this == OrderType.delayed;
}

class OrderModel {
  final String id;
  final OrderType orderType;
  final DateTime timestamp;
  final List<OrderItemModel> items;
  final List<OrderStatusModel> statusList;
  final double deliveryFee;
  final double packagingFee;
  // final int quantity;
  final double price;
  OrderModel(
      {required this.id,
      required this.orderType,
      required this.timestamp,
      required this.items,
      required this.statusList,
      required this.deliveryFee,
      required this.packagingFee,
      this.price = 0.0});

  double totalPrice() => (items.fold(
          0.0, (previousValue, element) => previousValue + element.price) +
      deliveryFee +
      packagingFee);
  // items
  //                                       .fold(0.0,
  //                                           (sum, item) => sum + item.price)
  OrderModel copyWith({
    String? id,
    OrderType? orderType,
    DateTime? timestamp,
    List<OrderItemModel>? items,
    List<OrderStatusModel>? statusList,
    double? deliveryFee,
    double? packagingFee,
    double? price,
  }) {
    return OrderModel(
      id: id ?? this.id,
      orderType: orderType ?? this.orderType,
      timestamp: timestamp ?? this.timestamp,
      items: items ?? this.items,
      statusList: statusList ?? this.statusList,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      packagingFee: packagingFee ?? this.packagingFee,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'orderType': orderType.name,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'items': items.map((x) => x.toMap()).toList(),
      'statusList': statusList.map((x) => x.toMap()).toList(),
      'deliveryFee': deliveryFee,
      'packagingFee': packagingFee,
      'price': price,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] as String,
      orderType: OrderType.instant,
      // orderType: OrderType.fromMap(map['orderType'] as Map<String, dynamic>),
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp'] as int),
      items: List<OrderItemModel>.from(
        (map['items'] as List<int>).map<OrderItemModel>(
          (x) => OrderItemModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      statusList: List<OrderStatusModel>.from(
        (map['statusList'] as List<int>).map<OrderStatusModel>(
          (x) => OrderStatusModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      deliveryFee: map['deliveryFee'] as double,
      packagingFee: map['packagingFee'] as double,
      price: map['price'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderModel(id: $id, orderType: $orderType, timestamp: $timestamp, items: $items, statusList: $statusList, deliveryFee: $deliveryFee, packagingFee: $packagingFee, price: $price)';
  }

  @override
  bool operator ==(covariant OrderModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.orderType == orderType &&
        other.timestamp == timestamp &&
        listEquals(other.items, items) &&
        listEquals(other.statusList, statusList) &&
        other.deliveryFee == deliveryFee &&
        other.packagingFee == packagingFee &&
        other.price == price;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        orderType.hashCode ^
        timestamp.hashCode ^
        items.hashCode ^
        statusList.hashCode ^
        deliveryFee.hashCode ^
        packagingFee.hashCode ^
        price.hashCode;
  }
}
