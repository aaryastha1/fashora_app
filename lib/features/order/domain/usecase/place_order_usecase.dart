// lib/features/order/domain/usecase/place_order_usecase.dart

import 'package:dartz/dartz.dart';
import 'package:fashora_app/core/error/failure.dart';
import 'package:fashora_app/features/order/domain/entity/order_item_entity.dart';
import 'package:fashora_app/features/order/domain/repository/order_repository.dart';

import 'package:fashora_app/features/order/domain/usecase/order_usecase.dart';

class PlaceOrderUseCase implements IPlaceOrderUseCase {
  final IOrderRepository orderRepository;

  PlaceOrderUseCase({required this.orderRepository});

  @override
  Future<Either<Failure, void>> placeOrder(OrderEntity order) {
    return orderRepository.placeOrder(order);
  }
}
