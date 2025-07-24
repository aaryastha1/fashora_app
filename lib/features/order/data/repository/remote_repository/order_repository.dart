// data/repository/order_repository_impl.dart

import 'package:dartz/dartz.dart';
import 'package:fashora_app/core/error/failure.dart';
import 'package:fashora_app/core/error/server_failure.dart';
import 'package:fashora_app/features/order/data/data_source/datasource.dart';
import 'package:fashora_app/features/order/data/model/order_model.dart';
import 'package:fashora_app/features/order/domain/entity/order_item_entity.dart';
import 'package:fashora_app/features/order/domain/repository/order_repository.dart';


class OrderRepositoryImpl implements IOrderRepository {
  final IOrderRemoteDataSource remoteDataSource;

  OrderRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, void>> placeOrder(OrderEntity order) async {
    try {
      final orderModel = OrderModel.fromEntity(order);
      await remoteDataSource.placeOrder(orderModel);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
