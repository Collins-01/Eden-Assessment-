// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

enum OrderStatus {
  // ignore: constant_identifier_names
  ORDER_PLACED,
  // ignore: constant_identifier_names
  ORDER_ACCEPTED,
  // ignore: constant_identifier_names
  ORDER_PICKUP_IN_PROGRESS,

  // ignore: constant_identifier_names
  ORDER_ON_THE_WAY,
  // ignore: constant_identifier_names
  ORDER_ARRIVED,
  // ignore: constant_identifier_names
  ORDER_DELIVERED,
}

extension OrderStatusExtension on OrderStatus {
  bool get isOrderPlaced => this == OrderStatus.ORDER_PLACED;
  bool get isOrderAccepted => this == OrderStatus.ORDER_ACCEPTED;
  bool get isOrderPickupInProgress =>
      this == OrderStatus.ORDER_PICKUP_IN_PROGRESS;
  bool get isOrderArrived => this == OrderStatus.ORDER_ARRIVED;
  bool get isOrderDelivered => this == OrderStatus.ORDER_DELIVERED;
  bool get isOrderOnTheWay => this == OrderStatus.ORDER_ON_THE_WAY;
}

class OrderStatusModel {
  final OrderStatus status;
  late final DateTime? timestamp;
  OrderStatusModel({
    required this.status,
    this.timestamp,
  });

  OrderStatusModel copyWith({
    OrderStatus? status,
    DateTime? timestamp,
  }) {
    return OrderStatusModel(
      status: status ?? this.status,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  static String statusToString(OrderStatus status) {
    switch (status) {
      case OrderStatus.ORDER_PLACED:
        return "Placed";

      case OrderStatus.ORDER_ACCEPTED:
        return "Accepted";
      case OrderStatus.ORDER_PICKUP_IN_PROGRESS:
        return "Pickup In Progress";
      case OrderStatus.ORDER_ON_THE_WAY:
        return "On the way";
      case OrderStatus.ORDER_ARRIVED:
        return "Arrived";

      case OrderStatus.ORDER_DELIVERED:
        return "Delivered";
    }
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status.name,
      'timestamp': timestamp?.millisecondsSinceEpoch,
    };
  }

  static OrderStatus statusFromString(String value) {
    switch (value) {
      case 'ORDER_PLACED':
        return OrderStatus.ORDER_PLACED;
      case 'ORDER_ACCEPTED':
        return OrderStatus.ORDER_ACCEPTED;
      case 'ORDER_PICKUP_IN_PROGRESS':
        return OrderStatus.ORDER_PICKUP_IN_PROGRESS;
      case 'ORDER_ON_THE_WAY':
        return OrderStatus.ORDER_ON_THE_WAY;
      case 'ORDER_ARRIVED':
        return OrderStatus.ORDER_ARRIVED;

      case 'ORDER_DELIVERED':
        return OrderStatus.ORDER_DELIVERED;
    }
    return OrderStatus.ORDER_PLACED;
  }

  factory OrderStatusModel.fromMap(Map<String, dynamic> map) {
    return OrderStatusModel(
      status: OrderStatusModel.statusFromString(map['status']),
      timestamp: map['timestamp'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['timestamp'] as int)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderStatusModel.fromJson(String source) =>
      OrderStatusModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'OrderStatusModel(status: $status, timestamp: $timestamp)';

  @override
  bool operator ==(covariant OrderStatusModel other) {
    if (identical(this, other)) return true;

    return other.status == status && other.timestamp == timestamp;
  }

  @override
  int get hashCode => status.hashCode ^ timestamp.hashCode;
}
