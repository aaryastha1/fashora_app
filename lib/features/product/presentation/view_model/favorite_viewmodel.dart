// import 'package:fashora_app/features/product/domain/entity/product_entity.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fashora_app/features/product/domain/repository/favorite_repository.dart';
// import 'favorite_event.dart';
// import 'favorite_state.dart';
// import 'package:dartz/dartz.dart';
// import 'package:fashora_app/core/error/failure.dart';

// class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
//   final IFavoriteRepository favoriteRepository;

//   FavoriteBloc(this.favoriteRepository) : super(FavoriteInitial()) {
//     on<LoadFavoritesEvent>(_onLoadFavorites);
//     on<ToggleFavoriteEvent>(_onToggleFavorite);
//   }

//   Future<void> _onLoadFavorites(
//       LoadFavoritesEvent event, Emitter<FavoriteState> emit) async {
//     emit(FavoriteLoading());
//     final Either<Failure, List<ProductEntity>> result =
//         await favoriteRepository.getFavorites();

//     result.fold(
//       (failure) => emit(FavoriteError(failure.message)),
//       (favorites) => emit(FavoriteLoaded(favorites)),
//     );
//   }

//   Future<void> _onToggleFavorite(
//       ToggleFavoriteEvent event, Emitter<FavoriteState> emit) async {
//     final Either<Failure, bool> toggleResult =
//         await favoriteRepository.toggleFavorite(event.productId);

//     toggleResult.fold(
//       (failure) => emit(FavoriteError(failure.message)),
//       (success) async {
//         if (success) {
//           final Either<Failure, List<ProductEntity>> updatedResult =
//               await favoriteRepository.getFavorites();
//           updatedResult.fold(
//             (failure) => emit(FavoriteError(failure.message)),
//             (updatedFavorites) => emit(FavoriteLoaded(updatedFavorites)),
//           );
//         } else {
//           emit(FavoriteError('Failed to toggle favorite'));
//         }
//       },
//     );
//   }
// }



import 'package:fashora_app/features/product/domain/entity/product_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'favorite_event.dart';
import 'favorite_state.dart';
import 'package:dartz/dartz.dart';
import 'package:fashora_app/core/error/failure.dart';
import 'package:fashora_app/features/product/domain/repository/favorite_repository.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final IFavoriteRepository favoriteRepository;

  FavoriteBloc(this.favoriteRepository) : super(FavoriteInitial()) {
    on<LoadFavoritesEvent>(_onLoadFavorites);
    on<ToggleFavoriteEvent>(_onToggleFavorite);
  }

  Future<void> _onLoadFavorites(LoadFavoritesEvent event, Emitter<FavoriteState> emit) async {
    emit(FavoriteLoading());
    final Either<Failure, List<ProductEntity>> result = await favoriteRepository.getFavorites();

    result.fold(
      (failure) => emit(FavoriteError(failure.message)),
      (favorites) => emit(FavoriteLoaded(favorites)),
    );
  }

  Future<void> _onToggleFavorite(ToggleFavoriteEvent event, Emitter<FavoriteState> emit) async {
    final Either<Failure, bool> toggleResult = await favoriteRepository.toggleFavorite(event.productId);

    toggleResult.fold(
      (failure) => emit(FavoriteError(failure.message)),
      (success) async {
        if (success) {
          final Either<Failure, List<ProductEntity>> updatedResult = await favoriteRepository.getFavorites();
          updatedResult.fold(
            (failure) => emit(FavoriteError(failure.message)),
            (updatedFavorites) => emit(FavoriteLoaded(updatedFavorites)),
          );
        } else {
          emit(FavoriteError('Failed to toggle favorite'));
        }
      },
    );
  }
}
