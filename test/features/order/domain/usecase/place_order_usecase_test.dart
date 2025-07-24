import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:fashora_app/core/error/failure.dart';
import 'package:fashora_app/core/error/server_failure.dart';
import 'package:fashora_app/features/order/domain/entity/order_item_entity.dart';
import 'package:fashora_app/features/order/domain/repository/order_repository.dart';
import 'package:fashora_app/features/order/domain/usecase/place_order_usecase.dart';

class MockOrderRepository extends Mock implements IOrderRepository {}

void main() {
  late PlaceOrderUseCase useCase;
  late MockOrderRepository mockRepository;

  setUp(() {
    mockRepository = MockOrderRepository();
    useCase = PlaceOrderUseCase(orderRepository: mockRepository); // ✅ fixed
  });

  final order = OrderEntity(
    fullName: 'Aarya Shrestha',
    address: 'Kathmandu, Nepal',
    phone: '9800000000',
    paymentMethod: 'cod',
    items: [
      OrderItemEntity(productId: 'prod1', quantity: 2),
      OrderItemEntity(productId: 'prod2', quantity: 1),
    ],
  );

  test('should return Right(void) when placeOrder is successful', () async {
    // Arrange
    when(() => mockRepository.placeOrder(order))
        .thenAnswer((_) async => const Right(null));

    // Act
    final result = await useCase.placeOrder(order);

    // Assert
    expect(result, const Right(null));
    verify(() => mockRepository.placeOrder(order)).called(1);
  });

  test('should return Left(ServerFailure) when placeOrder fails', () async {
    // Arrange
  final failure = ServerFailure(message: 'Server Error');

    when(() => mockRepository.placeOrder(order))
        .thenAnswer((_) async => Left(failure));

    // Act
    final result = await useCase.placeOrder(order);

    // Assert
    expect(result, Left(failure));
    verify(() => mockRepository.placeOrder(order)).called(1);
  });
}
