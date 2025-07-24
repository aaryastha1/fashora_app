import 'package:dartz/dartz.dart';
import 'package:fashora_app/core/error/failure.dart';

import 'package:fashora_app/features/product/domain/repository/favorite_repository.dart';
import 'package:fashora_app/features/product/domain/use_case/noparams.dart';

class ToggleFavoriteUseCase implements UseCase<bool, String> {
  final IFavoriteRepository repository;

  ToggleFavoriteUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> call(String productId) {
    return repository.toggleFavorite(productId);
  }
}
