// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';

// import 'package:fashora_app/features/order/presentation/view/order_succes_screen.dart';
// import 'package:fashora_app/features/product/presentation/view/home_screen.dart';

// class MockNavigatorObserver extends NavigatorObserver {
//   final List<Route> pushedRoutes = [];

//   @override
//   void didPush(Route route, Route? previousRoute) {
//     pushedRoutes.add(route);
//     super.didPush(route, previousRoute);
//   }
// }

// void main() {
//   testWidgets('OrderSuccessScreen navigates to FashoraHomeScreen on Continue Shopping tap', (tester) async {
//     const testUserId = 'user123';
//     final navigatorObserver = MockNavigatorObserver();

//     await tester.pumpWidget(
//       MaterialApp(
//         home: OrderSuccessScreen(userId: testUserId),
//         navigatorObservers: [navigatorObserver],
//       ),
//     );

//     expect(find.text('Continue Shopping'), findsOneWidget);

//     // Tap Continue Shopping button
//     await tester.tap(find.text('Continue Shopping'));
//     await tester.pumpAndSettle();

//     // Verify navigator pushed a MaterialPageRoute
//     expect(navigatorObserver.pushedRoutes.isNotEmpty, true);

//     final lastRoute = navigatorObserver.pushedRoutes.last;
//     expect(lastRoute, isA<MaterialPageRoute>());

//     final materialRoute = lastRoute as MaterialPageRoute;

//     // Use a valid BuildContext to call builder
//     final context = tester.element(find.byType(OrderSuccessScreen));
//     final widget = materialRoute.builder(context);

//     expect(widget, isA<FashoraHomeScreen>());

//     final homeScreen = widget as FashoraHomeScreen;
//     expect(homeScreen.userId, testUserId);
//   });
// }
