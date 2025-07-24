import 'package:fashora_app/features/product/presentation/view_model/product_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fashora_app/features/product/domain/use_case/get_products_by_category.dart';
import 'package:fashora_app/features/product/domain/use_case/search_usecase.dart';
import 'package:fashora_app/features/product/domain/entity/product_entity.dart';

import 'package:fashora_app/features/product/presentation/view_model/product_event.dart';
import 'package:fashora_app/features/product/presentation/view_model/product_state.dart';

// Mock classes
class MockGetProductsByCategoryUseCase extends Mock implements GetProductsByCategoryUseCase {}
class MockSearchProductsUseCase extends Mock implements SearchProductsUseCase {}

void main() {
  late MockGetProductsByCategoryUseCase mockGetProductsByCategoryUseCase;
  late MockSearchProductsUseCase mockSearchProductsUseCase;
  late ProductViewModel productViewModel;

  final testProducts = [
    ProductEntity(
      id: '1',
      name: 'T-Shirt',
      price: '1000',
      categoryName: 'Tops',
      sellerName: 'Fashora',
      image: 'tshirt.jpg',
      description: 'A comfortable cotton t-shirt',
      stock: 10,
    ),
  ];

  setUp(() {
    mockGetProductsByCategoryUseCase = MockGetProductsByCategoryUseCase();
    mockSearchProductsUseCase = MockSearchProductsUseCase();
    productViewModel = ProductViewModel(
      getProductsByCategoryUseCase: mockGetProductsByCategoryUseCase,
      searchProductsUseCase: mockSearchProductsUseCase,
    );
  });

  group('fetchProductsByCategory', () {
    test('emits [ProductLoading, ProductLoaded] when data is fetched successfully', () async {
      when(() => mockGetProductsByCategoryUseCase.call('Tops'))
          .thenAnswer((_) async => testProducts);

      final expectedStates = [
        ProductLoading(),
        ProductLoaded(testProducts),
      ];

      expectLater(productViewModel.stream, emitsInOrder(expectedStates));

      await productViewModel.fetchProductsByCategory('Tops');
    });

    test('emits [ProductLoading, ProductError] when fetching fails', () async {
      when(() => mockGetProductsByCategoryUseCase.call('Tops'))
          .thenThrow(Exception('Failed to fetch products'));

      final expectedStates = [
        ProductLoading(),
        isA<ProductError>(),
      ];

      expectLater(productViewModel.stream, emitsInOrder(expectedStates));

      await productViewModel.fetchProductsByCategory('Tops');
    });
  });

  group('searchProducts', () {
    test('emits [ProductLoading, ProductLoaded] when search succeeds', () async {
      when(() => mockSearchProductsUseCase.call('shirt'))
          .thenAnswer((_) async => testProducts);

      final expectedStates = [
        ProductLoading(),
        ProductLoaded(testProducts),
      ];

      expectLater(productViewModel.stream, emitsInOrder(expectedStates));

      await productViewModel.searchProducts('shirt');
    });

    test('emits [ProductLoading, ProductError] when search fails', () async {
      when(() => mockSearchProductsUseCase.call('shirt'))
          .thenThrow(Exception('Search failed'));

      final expectedStates = [
        ProductLoading(),
        isA<ProductError>(),
      ];

      expectLater(productViewModel.stream, emitsInOrder(expectedStates));

      await productViewModel.searchProducts('shirt');
    });
  });
}
