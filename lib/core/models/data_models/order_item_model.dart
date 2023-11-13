// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class OrderItemModel {
  final String id;
  final String name;
  final double price;
  final String image;
  final int quantity;
  OrderItemModel({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    this.quantity = 1,
  });

  OrderItemModel copyWith({
    String? id,
    String? name,
    double? price,
    String? image,
    int? quantity,
  }) {
    return OrderItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      image: image ?? this.image,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'price': price,
      'image': image,
      'quantity': quantity,
    };
  }

  factory OrderItemModel.fromMap(Map<String, dynamic> map) {
    return OrderItemModel(
      id: map['id'] as String,
      name: map['name'] as String,
      price: map['price'] as double,
      image: map['image'] as String,
      quantity: map['quantity'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderItemModel.fromJson(String source) =>
      OrderItemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderItemModel(id: $id, name: $name, price: $price, image: $image, quantity: $quantity)';
  }

  @override
  bool operator ==(covariant OrderItemModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.price == price &&
        other.image == image &&
        other.quantity == quantity;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        price.hashCode ^
        image.hashCode ^
        quantity.hashCode;
  }
}
