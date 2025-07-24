// import 'package:fashora_app/features/product/domain/use_case/get_favorite.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';

// import 'package:fashora_app/features/product/domain/entity/product_entity.dart';
// import 'package:fashora_app/features/product/domain/repository/favorite_repository.dart';
//  // Adjust import if needed

// class MockFavoriteRepository extends Mock implements IFavoriteRepository {}

// void main() {
//   late MockFavoriteRepository mockRepository;
//   late GetFavoritesUseCase getFavoritesUseCase;
//   late ToggleFavoriteUseCase toggleFavoriteUseCase;

//   setUp(() {
//     mockRepository = MockFavoriteRepository();
//     getFavoritesUseCase = GetFavoritesUseCase(repository: mockRepository);
//     toggleFavoriteUseCase = ToggleFavoriteUseCase(repository: mockRepository);
//   });

//   final mockFavorites = [
//     const ProductEntity(
//       id: '1',
//       name: 'Top 1',
//       price: '1500',
//       categoryName: 'Tops',
//       sellerName: 'Seller A',
//       image: 'image1.jpg',
//       description: 'Description 1',
//       stock: 5,
//     ),
//     const ProductEntity(
//       id: '2',
//       name: 'Dress 1',
//       price: '2000',
//       categoryName: 'Dresses',
//       sellerName: 'Seller B',
//       image: 'image2.jpg',
//       description: 'Description 2',
//       stock: 3,
//     ),
//   ];

//   group('GetFavoritesUseCase', () {
//     test('should return list of favorite products', () async {
//       // arrange
//       when(() => mockRepository.getFavorites())
//           .thenAnswer((_) async => mockFavorites);

//       // act
//       final result = await getFavoritesUseCase();

//       // assert
//       expect(result, mockFavorites);
//       verify(() => mockRepository.getFavorites()).called(1);
//     });
//   });

//   group('ToggleFavoriteUseCase', () {
//     const productId = '1';

//     test('should toggle favorite and return new status', () async {
//       // arrange
//       when(() => mockRepository.toggleFavorite(productId))
//           .thenAnswer((_) async => true);

//       // act
//       final result = await toggleFavoriteUseCase(productId);

//       // assert
//       expect(result, true);
//       verify(() => mockRepository.toggleFavorite(productId)).called(1);
//     });
//   });
// }
