// domain/entity/order_entity.dart

import 'order_item_entity.dart';

class OrderEntity {
  final String fullName;
  final String address;
  final String phone;
  final String paymentMethod; // e.g. 'cod', 'esewa', 'khalti'
  final List<OrderItemEntity> items;

  OrderEntity({
    required this.fullName,
    required this.address,
    required this.phone,
    required this.paymentMethod,
    required this.items,
  });
}

class OrderItemEntity {
  final String productId;
  final int quantity;

  OrderItemEntity({
    required this.productId,
    required this.quantity,
  });
}
