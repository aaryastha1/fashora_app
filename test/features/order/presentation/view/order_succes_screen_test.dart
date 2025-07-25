// import 'package:fashora_app/features/order/presentation/view/order_succes_screen.dart';
// import 'package:fashora_app/features/product/presentation/view/home_screen.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';

// void main() {
//   testWidgets('renders success UI and navigates to FashoraHomeScreen on tap', (WidgetTester tester) async {
//     const testUserId = 'test_user_123';

//     await tester.pumpWidget(
//       MaterialApp(
//         home: OrderSuccessScreen(userId: testUserId),
//       ),
//     );

//     // Check if main UI elements are shown
//     expect(find.text('Order Placed Successfully!'), findsOneWidget);
//     expect(find.text('Thank you for shopping with Fashora.'), findsOneWidget);
//     expect(find.text('Continue Shopping'), findsOneWidget);
//     expect(find.byIcon(Icons.check_circle_outline), findsOneWidget);

//     // Tap the button
//     await tester.tap(find.text('Continue Shopping'));
//     await tester.pumpAndSettle();

//     // Verify navigation
//     expect(find.byType(FashoraHomeScreen), findsOneWidget);
//   });
// }
