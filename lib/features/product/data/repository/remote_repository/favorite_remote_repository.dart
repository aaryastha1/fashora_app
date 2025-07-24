// lib/features/product/data/repository/favorite_remote_repository.dart
import 'package:dartz/dartz.dart';
import 'package:fashora_app/core/error/failure.dart';
import 'package:fashora_app/core/error/server_failure.dart';
import 'package:fashora_app/features/product/data/data_sorce/favorite_data_source.dart';
import 'package:fashora_app/features/product/domain/entity/product_entity.dart';
import 'package:fashora_app/features/product/domain/repository/favorite_repository.dart';


class FavoriteRemoteRepository implements IFavoriteRepository {
  final IFavoriteDataSource dataSource;

  FavoriteRemoteRepository(this.dataSource);

  @override
  Future<Either<Failure, List<ProductEntity>>> getFavorites() async {
    try {
      final favorites = await dataSource.getFavorites();
      return Right(favorites);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));

    }
  }

  @override
  Future<Either<Failure, bool>> toggleFavorite(String productId) async {
    try {
      final result = await dataSource.toggleFavorite(productId);
      return Right(result);
    } catch (e) {
    return Left(ServerFailure(message: e.toString()));

    }
  }
}
