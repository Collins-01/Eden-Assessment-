// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

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
  final OrderStatusModel status;
  OrderModel({
    required this.id,
    required this.orderType,
    required this.timestamp,
    required this.status,
  });

  OrderModel copyWith({
    String? id,
    OrderType? orderType,
    DateTime? timestamp,
    OrderStatusModel? status,
  }) {
    return OrderModel(
      id: id ?? this.id,
      orderType: orderType ?? this.orderType,
      timestamp: timestamp ?? this.timestamp,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'orderType': orderType.isDelayed,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'status': status.toMap(),
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] as String,
      orderType: OrderType.delayed,
      //  OrderType.fromMap(map['orderType'] as Map<String, dynamic>),
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp'] as int),
      status: OrderStatusModel.fromMap(map['status'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderModel(id: $id, orderType: $orderType, timestamp: $timestamp, status: $status)';
  }

  @override
  bool operator ==(covariant OrderModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.orderType == orderType &&
        other.timestamp == timestamp &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        orderType.hashCode ^
        timestamp.hashCode ^
        status.hashCode;
  }
}
