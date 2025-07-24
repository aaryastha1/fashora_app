import 'package:dartz/dartz.dart';
import 'package:fashora_app/core/error/failure.dart';
import 'package:fashora_app/features/product/domain/entity/product_entity.dart';

abstract class IFavoriteRepository {
  Future<Either<Failure, List<ProductEntity>>> getFavorites();
  Future<Either<Failure, bool>> toggleFavorite(String productId);
}
