import 'package:dartz/dartz.dart';
import 'package:fashora_app/core/error/failure.dart';
import 'package:fashora_app/features/order/domain/entity/order_item_entity.dart';


abstract class IPlaceOrderUseCase {
  Future<Either<Failure, void>> placeOrder(OrderEntity order);
}
