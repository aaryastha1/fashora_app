import 'package:dartz/dartz.dart';
import 'package:fashora_app/core/error/server_failure.dart';
import 'package:fashora_app/features/product/domain/use_case/get_favorite.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:fashora_app/features/product/domain/entity/product_entity.dart';

import 'package:fashora_app/features/product/domain/use_case/noparams.dart';
import 'package:fashora_app/core/error/failure.dart';
import 'package:fashora_app/features/product/domain/repository/favorite_repository.dart';

// Mock Repository
class MockFavoriteRepository extends Mock implements IFavoriteRepository {}

void main() {
  late GetFavoritesUseCase useCase;
  late MockFavoriteRepository mockRepository;

  setUp(() {
    mockRepository = MockFavoriteRepository();
    useCase = GetFavoritesUseCase(repository: mockRepository);
  });

  const testFavorites = [
    ProductEntity(
      id: 'p1',
      name: 'Chic Top',
      price: '2500',
      categoryName: 'Tops',
      sellerName: 'Fashora Seller',
      image: 'image1.jpg',
      description: 'Trendy chic top for summer',
      stock: 10,
    ),
  ];

  test('should return list of favorite products when repository returns data', () async {
    // Arrange
    when(() => mockRepository.getFavorites())
        .thenAnswer((_) async => const Right(testFavorites));

    // Act
    final result = await useCase(NoParams());

    // Assert
    expect(result, const Right(testFavorites));
    verify(() => mockRepository.getFavorites()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return Failure when repository fails', () async {
    // Arrange
    final failure = ServerFailure(message: 'Something went wrong');
    when(() => mockRepository.getFavorites())
        .thenAnswer((_) async => Left(failure));

    // Act
    final result = await useCase(NoParams());

    // Assert
    expect(result, Left(failure));
    verify(() => mockRepository.getFavorites()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
