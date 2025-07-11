import 'package:fashora_app/features/auth/presentation/view/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fashora_app/features/auth/presentation/view_model/register_view_model/register_view_model.dart';

class MockRegisterViewModel extends Mock implements RegisterViewModel {}

void main() {
  late RegisterViewModel mockRegisterViewModel;

  setUp(() {
    mockRegisterViewModel = MockRegisterViewModel();
  });

  Widget loadRegisterView() {
    return MaterialApp(
      home: Scaffold(
        body: BlocProvider<RegisterViewModel>(
          create: (_) => mockRegisterViewModel,
          child: const RegisterView(),
        ),
      ),
    );
  }

  testWidgets('Show validation errors on empty form submission', (tester) async {
    await tester.pumpWidget(loadRegisterView());
    await tester.pumpAndSettle();

    // Find the Register button
    final registerButton = find.widgetWithText(ElevatedButton, 'Register');
    expect(registerButton, findsOneWidget);

    // Ensure it's visible before tapping (solves your offset error!)
    await tester.ensureVisible(registerButton);
    await tester.tap(registerButton);
    await tester.pumpAndSettle();

    // Validate error messages appear
    expect(find.text('Full name is required'), findsOneWidget);
    expect(find.text('Email is required'), findsOneWidget);
    expect(find.text('Phone number is required'), findsOneWidget);
    expect(find.text('Password must be at least 6 characters'), findsOneWidget);
  });





    testWidgets('Form fills successfully with valid input', (tester) async {
      await tester.pumpWidget(loadRegisterView());
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextFormField).at(0), 'aarya shrestha');
      await tester.enterText(find.byType(TextFormField).at(1), 'aarya@example.com');
      await tester.enterText(find.byType(TextFormField).at(2), '9812345678');
      await tester.enterText(find.byType(TextFormField).at(3), 'password123');

      // Tap register
      await tester.tap(find.text('Register'));
      await tester.pumpAndSettle();

      // Expect no validation error messages
      expect(find.textContaining('required'), findsNothing);
      expect(find.textContaining('valid'), findsNothing);
    });
  
}
