// favorite_bloc_test.dart

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:fashora_app/core/error/failure.dart';
import 'package:fashora_app/features/product/domain/entity/product_entity.dart';
import 'package:fashora_app/features/product/domain/repository/favorite_repository.dart';

import 'package:fashora_app/features/product/presentation/view_model/favorite_event.dart';
import 'package:fashora_app/features/product/presentation/view_model/favorite_state.dart';
import 'package:fashora_app/features/product/presentation/view_model/favorite_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// ✅ Create a mock for IFavoriteRepository
class MockFavoriteRepository extends Mock implements IFavoriteRepository {}

// ✅ Create a concrete implementation of Failure for testing
class FakeFailure extends Failure {
  FakeFailure(String message) : super(message: message);
}

void main() {
  late MockFavoriteRepository mockRepository;
  late FavoriteBloc favoriteBloc;

  setUp(() {
    mockRepository = MockFavoriteRepository();
    favoriteBloc = FavoriteBloc(mockRepository);
  });

  final mockProduct = ProductEntity(
    id: '1',
    name: 'Test Product',
    price: '200',
    categoryName: 'Shirt',
    sellerName: 'Test Seller',
    image: 'test.jpg',
    description: 'Test desc',
    stock: 5,
  );

  group('FavoriteBloc', () {
    blocTest<FavoriteBloc, FavoriteState>(
      'emits [FavoriteLoading, FavoriteLoaded] when LoadFavoritesEvent is successful',
      build: () {
        when(() => mockRepository.getFavorites())
            .thenAnswer((_) async => Right([mockProduct]));
        return favoriteBloc;
      },
      act: (bloc) => bloc.add(LoadFavoritesEvent()),
      expect: () => [
        FavoriteLoading(),
        FavoriteLoaded([mockProduct]),
      ],
    );

    blocTest<FavoriteBloc, FavoriteState>(
      'emits [FavoriteLoading, FavoriteError] when LoadFavoritesEvent fails',
      build: () {
        when(() => mockRepository.getFavorites())
            .thenAnswer((_) async => Left(FakeFailure('Failed')));
        return favoriteBloc;
      },
      act: (bloc) => bloc.add(LoadFavoritesEvent()),
      expect: () => [
        FavoriteLoading(),
        FavoriteError('Failed'),
      ],
    );

    // blocTest<FavoriteBloc, FavoriteState>(
    //   'emits [FavoriteLoaded] with updated list after ToggleFavoriteEvent success',
    //   build: () {
    //     when(() => mockRepository.toggleFavorite('1'))
    //         .thenAnswer((_) async => const Right(true));
    //     when(() => mockRepository.getFavorites())
    //         .thenAnswer((_) async => Right([mockProduct]));
    //     return favoriteBloc;
    //   },
    //   act: (bloc) => bloc.add(ToggleFavoriteEvent('1')),
    //   expect: () => [
    //     FavoriteLoaded([mockProduct]),
    //   ],
    // );

    blocTest<FavoriteBloc, FavoriteState>(
      'emits [FavoriteError] when ToggleFavoriteEvent fails',
      build: () {
        when(() => mockRepository.toggleFavorite('1'))
            .thenAnswer((_) async => Left(FakeFailure('Toggle failed')));
        return favoriteBloc;
      },
      act: (bloc) => bloc.add(ToggleFavoriteEvent( '1')),
      expect: () => [
        FavoriteError('Toggle failed'),
      ],
    );
  });
}
