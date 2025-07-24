import 'package:dartz/dartz.dart';
import 'package:fashora_app/core/error/server_failure.dart';

import 'package:fashora_app/features/order/domain/entity/order_item_entity.dart';
import 'package:fashora_app/features/order/presentation/view_model/order_event.dart';
import 'package:fashora_app/features/order/presentation/view_model/order_state.dart';
import 'package:fashora_app/features/order/presentation/view_model/order_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

import 'package:fashora_app/features/order/domain/usecase/order_usecase.dart';

// Mock class for IPlaceOrderUseCase
class MockPlaceOrderUseCase extends Mock implements IPlaceOrderUseCase {}

// Fake OrderEntity for registering fallback value for mocktail
class FakeOrderEntity extends Fake implements OrderEntity {}

void main() {
  late MockPlaceOrderUseCase mockUseCase;

  setUpAll(() {
    registerFallbackValue(FakeOrderEntity());
  });

  setUp(() {
    mockUseCase = MockPlaceOrderUseCase();
  });

  Widget makeTestableWidget(OrderBloc bloc) {
    return MaterialApp(
      home: BlocProvider<OrderBloc>(
        create: (_) => bloc,
        child: Scaffold(
          body: BlocBuilder<OrderBloc, OrderState>(
            builder: (context, state) {
              if (state is OrderLoading) {
                return const CircularProgressIndicator();
              } else if (state is OrderSuccess) {
                return const Text('Order Placed Successfully!');
              } else if (state is OrderFailure) {
                return Text(state.message);
              }
              return ElevatedButton(
                onPressed: () {
                  // Provide a dummy order for testing
                  final dummyOrder = OrderEntity(
                    fullName: 'Test User',
                    address: '123 Test St',
                    phone: '1234567890',
                    paymentMethod: 'cod',
                    items: [],
                  );
                  context.read<OrderBloc>().add(PlaceOrderEvent(dummyOrder));
                },
                child: const Text('Place Order'),
              );
            },
          ),
        ),
      ),
    );
  }

  testWidgets('shows loading then success on successful order', (tester) async {
    // Mock use case returns success with a small delay to simulate async
    when(() => mockUseCase.placeOrder(any())).thenAnswer((_) async {
      await Future.delayed(const Duration(milliseconds: 10));
      return const Right(null);
    });

    final bloc = OrderBloc(placeOrderUseCase: mockUseCase);

    await tester.pumpWidget(makeTestableWidget(bloc));

    expect(find.text('Place Order'), findsOneWidget);

    await tester.tap(find.text('Place Order'));
    await tester.pump(); // start event processing

    // Loading indicator should show now
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pumpAndSettle();

    // Success message shown
    expect(find.text('Order Placed Successfully!'), findsOneWidget);
  });

  testWidgets('shows loading then failure message on failed order', (tester) async {
    // Mock use case returns failure with a small delay
    when(() => mockUseCase.placeOrder(any())).thenAnswer((_) async {
      await Future.delayed(const Duration(milliseconds: 10));
      return Left(ServerFailure(message: 'Server error'));
    });

    final bloc = OrderBloc(placeOrderUseCase: mockUseCase);

    await tester.pumpWidget(makeTestableWidget(bloc));

    expect(find.text('Place Order'), findsOneWidget);

    await tester.tap(find.text('Place Order'));
    await tester.pump(); // start event processing

    // Loading indicator should show now
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pumpAndSettle();

    // Failure message shown
    expect(find.text('Server error'), findsOneWidget);
  });
}
