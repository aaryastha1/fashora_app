import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:fashora_app/features/cart/domain/usecase/add_to_cart_usecase.dart';
import 'package:fashora_app/features/cart/domain/repository/cart_repository.dart';
import 'package:fashora_app/features/cart/domain/entity/cart_entity.dart';
import 'package:fashora_app/features/cart/domain/entity/cart_item_entity.dart';

// Mock repository
class MockCartRepository extends Mock implements ICartRepository {}

void main() {
  late MockCartRepository mockCartRepository;
  late AddToCartUseCase addToCartUseCase;

  setUp(() {
    mockCartRepository = MockCartRepository();
    addToCartUseCase = AddToCartUseCase(mockCartRepository);
  });

  const testProductId = 'product_123';

  // Sample cart item
  final cartItem = CartItemEntity(
    id: 'product_123',
    name: 'Test Product',
    image: 'test_image.png',
    quantity: 1,
    price: 999.99,
  );

  // Sample cart entity with items
  final testCartEntity = CartEntity(
    items: [cartItem],
  );

  test('should call addToCart on repository and return CartEntity', () async {
    // Arrange
    when(() => mockCartRepository.addToCart(testProductId))
        .thenAnswer((_) async => testCartEntity);

    // Act
    final result = await addToCartUseCase.call(testProductId);

    // Assert
    expect(result, testCartEntity);
    verify(() => mockCartRepository.addToCart(testProductId)).called(1);
  });
}
