// features/order/presentation/view_model/order_event.dart

import 'package:equatable/equatable.dart';

import 'package:fashora_app/features/order/domain/entity/order_item_entity.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();
}

class PlaceOrderEvent extends OrderEvent {
  final OrderEntity order;

  const PlaceOrderEvent(this.order);

  @override
  List<Object> get props => [order];
}
