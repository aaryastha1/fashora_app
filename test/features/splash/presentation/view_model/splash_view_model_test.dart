import 'package:fashora_app/app/service_locator/service_locator.dart';
import 'package:fashora_app/features/auth/presentation/view/login.dart';
import 'package:fashora_app/features/auth/presentation/view_model/login_view_model/login_view_model.dart';
import 'package:fashora_app/features/splash/presentation/view_model/splash_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockLoginViewModel extends Mock implements LoginViewModel {}

void main() {
  setUpAll(() {
    // Register mock login view model in service locator
    serviceLocator.registerFactory<LoginViewModel>(() => MockLoginViewModel());
  });

  testWidgets('SplashViewModel navigates to LoginPage after delay', (tester) async {
    final splashViewModel = SplashViewModel();

    // Build a MaterialApp with dummy Splash screen
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            // Trigger init manually using context
            splashViewModel.init(context);
            return const Scaffold(body: Text('Splash'));
          },
        ),
      ),
    );

    // Wait 2 seconds + navigation
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    // Expect LoginPage to be present
    expect(find.byType(LoginPage), findsOneWidget);
  });
}
