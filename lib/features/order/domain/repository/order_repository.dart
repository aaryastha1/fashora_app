// domain/repository/order_repository.dart

import 'package:dartz/dartz.dart';
import 'package:fashora_app/core/error/failure.dart';
import 'package:fashora_app/features/order/domain/entity/order_item_entity.dart';


abstract class IOrderRepository {
  Future<Either<Failure, void>> placeOrder(OrderEntity order);
}
