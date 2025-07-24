// lib/features/product/domain/usecase/get_favorites_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:fashora_app/core/error/failure.dart';
import 'package:fashora_app/features/product/domain/use_case/noparams.dart';
import '../repository/favorite_repository.dart';
import '../entity/product_entity.dart';

class GetFavoritesUseCase implements UseCase<List<ProductEntity>, NoParams> {
  final IFavoriteRepository repository;

  GetFavoritesUseCase({required this.repository});

  @override
  Future<Either<Failure, List<ProductEntity>>> call(NoParams params) {
    return repository.getFavorites();
  }
}
