// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

enum OrderType { instant, delayed }

extension OrderTypeExtension on OrderType {
  bool get isInstant => this == OrderType.instant;
  bool get isDelayed => this == OrderType.delayed;
}

enum OrderStatus {
  // ignore: constant_identifier_names
  ORDER_PLACED,
  // ignore: constant_identifier_names
  ORDER_ACCEPTED,
  // ignore: constant_identifier_names
  ORDER_PICKUP_IN_PROGRESS,
  // ignore: constant_identifier_names
  ORDER_ARRIVED,
  // ignore: constant_identifier_names
  ORDER_DELIVERED,
}

class OrderModel {
  final String id;
  final OrderType orderType;
  final DateTime timestamp;
  final OrderStatus status;
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
    OrderStatus? status,
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
      'orderType': orderType.name,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'status': status.name,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] as String,
      orderType: OrderType.instant,
      // orderType: OrderType.fromMap(map['orderType'] as Map<String, dynamic>),
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp'] as int),
      // status: OrderStatus.fromMap(map['status'] as Map<String, dynamic>),
      status: OrderStatus.ORDER_ACCEPTED,
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
