// data/model/order_model.dart

import 'package:equatable/equatable.dart';
import 'package:fashora_app/features/order/domain/entity/order_item_entity.dart';


class OrderItemModel extends Equatable {
  final String productId;
  final int quantity;

  const OrderItemModel({
    required this.productId,
    required this.quantity,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      productId: json['productId']?.toString() ?? '',
      quantity: json['quantity'] is int
          ? json['quantity']
          : int.tryParse(json['quantity']?.toString() ?? '0') ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'quantity': quantity,
    };
  }

  OrderItemEntity toEntity() {
    return OrderItemEntity(productId: productId, quantity: quantity);
  }

  factory OrderItemModel.fromEntity(OrderItemEntity entity) {
    return OrderItemModel(
      productId: entity.productId,
      quantity: entity.quantity,
    );
  }

  @override
  List<Object?> get props => [productId, quantity];
}

class OrderModel extends Equatable {
  final String fullName;
  final String address;
  final String phone;
  final String paymentMethod;
  final List<OrderItemModel> items;

  const OrderModel({
    required this.fullName,
    required this.address,
    required this.phone,
    required this.paymentMethod,
    required this.items,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    final itemsJson = json['items'] as List<dynamic>? ?? [];
    return OrderModel(
      fullName: json['fullName']?.toString() ?? '',
      address: json['address']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      paymentMethod: json['paymentMethod']?.toString() ?? 'cod',
      items: itemsJson
          .map((item) => OrderItemModel.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'address': address,
      'phone': phone,
      'paymentMethod': paymentMethod,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }

  OrderEntity toEntity() {
    return OrderEntity(
      fullName: fullName,
      address: address,
      phone: phone,
      paymentMethod: paymentMethod,
      items: items.map((item) => item.toEntity()).toList(),
    );
  }

  factory OrderModel.fromEntity(OrderEntity entity) {
    return OrderModel(
      fullName: entity.fullName,
      address: entity.address,
      phone: entity.phone,
      paymentMethod: entity.paymentMethod,
      items: entity.items.map((item) => OrderItemModel.fromEntity(item)).toList(),
    );
  }

  @override
  List<Object?> get props => [fullName, address, phone, paymentMethod, items];
}
