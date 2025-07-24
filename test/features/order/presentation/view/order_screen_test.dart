// import 'package:bloc_test/bloc_test.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:fashora_app/features/order/domain/entity/order_item_entity.dart';
// import 'package:fashora_app/features/order/presentation/view/order_screen.dart';
// import 'package:fashora_app/features/order/presentation/view/order_succes_screen.dart';
// import 'package:fashora_app/features/order/presentation/view_model/order_event.dart';
// import 'package:fashora_app/features/order/presentation/view_model/order_state.dart';
// import 'package:fashora_app/features/order/presentation/view_model/order_viewmodel.dart';

// class MockOrderBloc extends MockBloc<OrderEvent, OrderState> implements OrderBloc {}

// class FakeOrderEvent extends Fake implements OrderEvent {}

// class FakeOrderState extends Fake implements OrderState {}

// void main() {
//   late MockOrderBloc mockOrderBloc;

//   setUpAll(() {
//     registerFallbackValue(FakeOrderEvent());
//     registerFallbackValue(FakeOrderState());
//   });

//   setUp(() {
//     mockOrderBloc = MockOrderBloc();
//   });

//   Widget createWidgetUnderTest(List<OrderItemEntity> items) {
//     return MaterialApp(
//       home: BlocProvider<OrderBloc>(
//         create: (_) => mockOrderBloc,
//         child: OrderScreen(items: items),
//       ),
//     );
//   }

//   testWidgets('fills form and triggers PlaceOrderEvent and navigates on success', (tester) async {
//     final testItems = [
//       OrderItemEntity(productId: '1', quantity: 1),
//     ];

//     when(() => mockOrderBloc.state).thenReturn(OrderInitial());
//     whenListen(
//       mockOrderBloc,
//       Stream.fromIterable([
//         OrderLoading(),
//         OrderSuccess(),
//       ]),
//     );

//     await tester.pumpWidget(createWidgetUnderTest(testItems));

//     // Fill text fields by semantics label
//     await tester.enterText(find.bySemanticsLabel('Full Name'), 'Aarya');
//     await tester.enterText(find.bySemanticsLabel('Address'), 'Kathmandu');
//     await tester.enterText(find.bySemanticsLabel('Phone Number'), '9800000000');

//     // Tap the place order button using the key
//     await tester.tap(find.byKey(const Key('placeOrderButton')));
//     await tester.pump(); // Start loading state
//     await tester.pump(const Duration(milliseconds: 500)); // simulate loading delay
//     await tester.pumpAndSettle(); // wait for navigation to complete

//     // Verify OrderSuccessScreen is shown
//     expect(find.byType(OrderSuccessScreen), findsOneWidget);
//   });

//   testWidgets('shows error snackbar on OrderFailure', (tester) async {
//     final testItems = [
//       OrderItemEntity(productId: '1', quantity: 1),
//     ];

//     when(() => mockOrderBloc.state).thenReturn(OrderInitial());
//     whenListen(
//       mockOrderBloc,
//       Stream.fromIterable([
//         OrderLoading(),
//         OrderFailure('Something went wrong'),
//       ]),
//     );

//     await tester.pumpWidget(createWidgetUnderTest(testItems));

//     // Fill text fields
//     await tester.enterText(find.bySemanticsLabel('Full Name'), 'Aarya');
//     await tester.enterText(find.bySemanticsLabel('Address'), 'Kathmandu');
//     await tester.enterText(find.bySemanticsLabel('Phone Number'), '9800000000');

//     // Tap the place order button
//     await tester.tap(find.byKey(const Key('placeOrderButton')));
//     await tester.pump(); // Start loading
//     await tester.pump(); // Fail state arrives
//     await tester.pump(const Duration(seconds: 1)); // Show snackbar duration

//     // Verify snackbar with error message
//     expect(find.text('Something went wrong'), findsOneWidget);
//   });
// }
