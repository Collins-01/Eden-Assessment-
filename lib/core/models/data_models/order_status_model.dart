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
  ORDER_ARRIVED,
  // ignore: constant_identifier_names
  ORDER_DELIVERED,
}

class OrderStatusModel {
  final OrderStatus status;
  final DateTime timestamp;
  OrderStatusModel({
    required this.status,
    required this.timestamp,
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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status.name,
      'timestamp': timestamp.millisecondsSinceEpoch,
    };
  }

  factory OrderStatusModel.fromMap(Map<String, dynamic> map) {
    return OrderStatusModel(
      status: OrderStatus.ORDER_ACCEPTED,
      // OrderStatus.fromMap(map['status'] as Map<String, dynamic>),
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp'] as int),
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
