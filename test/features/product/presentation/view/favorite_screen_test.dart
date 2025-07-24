// import 'package:fashora_app/features/product/domain/entity/product_entity.dart';
// import 'package:fashora_app/features/product/domain/use_case/get_favorite.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';

// import '../../domain/use_case/get_favorite_test.dart';

// void main() {
//   late MockFavoriteRepository mockRepository;
//   late GetFavoritesUseCase useCase;

//   setUp(() {
//     mockRepository = MockFavoriteRepository();
//     useCase = GetFavoritesUseCase(repository: mockRepository);
//   });

//   test('should return list of favorite products from repository', () async {
//     // Arrange
//     final products = [
//       const ProductEntity(
//         id: '1',
//         name: 'T-shirt',
//         price: '500',
//         categoryName: 'Tops',
//         sellerName: 'Fashora',
//         image: 'image.jpg',
//         description: 'Cool shirt',
//         stock: 20,
//       ),
//     ];

//     when(() => mockRepository.getFavorites()).thenAnswer((_) async => products);

//     // Act
//     final result = await useCase();

//     // Assert
//     expect(result, products);
//     verify(() => mockRepository.getFavorites()).called(1);
//     verifyNoMoreInteractions(mockRepository);
//   });
// }
