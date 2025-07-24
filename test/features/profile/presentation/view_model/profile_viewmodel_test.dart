import 'package:dartz/dartz.dart';
import 'package:fashora_app/features/profile/domain/usecase/get_profile_usecase.dart';
import 'package:fashora_app/features/profile/domain/usecase/update_profile_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

import 'package:fashora_app/features/profile/presentation/view/profile_screen.dart';
import 'package:fashora_app/features/profile/presentation/view_model/profile_viewmodel.dart';
import 'package:fashora_app/features/profile/presentation/view_model/profile_event.dart';
import 'package:fashora_app/features/profile/presentation/view_model/profile_state.dart';
import 'package:fashora_app/features/profile/domain/entity/profile_entity.dart';
import 'package:fashora_app/features/auth/presentation/view/login.dart';

// Mocks for UseCases
class MockGetProfileUseCase extends Mock implements GetProfile {}
class MockUpdateProfileUseCase extends Mock implements UpdateProfileUsecase {}

// Real Bloc, but with mocked UseCases
class TestableProfileBloc extends ProfileBloc {
  TestableProfileBloc(GetProfile getProfile, UpdateProfileUsecase updateProfile) : super(getProfile, updateProfile);
}

void main() {
  late MockGetProfileUseCase mockGetProfileUseCase;
  late MockUpdateProfileUseCase mockUpdateProfileUseCase;
  late ProfileBloc profileBloc;

  const testProfile = ProfileEntity(
    userId: '123',
    name: 'John Doe',
    email: 'john@example.com',
    phoneNumber: '1234567890',
    profileImageUrl: 'url',
    address: 'Kathmandu',
  );

  setUp(() {
    mockGetProfileUseCase = MockGetProfileUseCase();
    mockUpdateProfileUseCase = MockUpdateProfileUseCase();
    profileBloc = TestableProfileBloc(mockGetProfileUseCase, mockUpdateProfileUseCase);

    // Register fallback values for any params if needed by mocktail
    registerFallbackValue(testProfile);
  });

  Widget buildTestableWidget() {
    return MaterialApp(
      home: BlocProvider.value(
        value: profileBloc,
        child: const ProfileScreen(userId: '123'),
      ),
    );
  }



  testWidgets('shows profile info when loaded', (tester) async {
    when(() => mockGetProfileUseCase.call())
        .thenAnswer((_) async => Right(testProfile));

    profileBloc.emit(ProfileLoaded(testProfile));
    await tester.pumpWidget(buildTestableWidget());
    await tester.pumpAndSettle();

    expect(find.text('John Doe'), findsOneWidget);
    expect(find.text('john@example.com'), findsOneWidget);
  });

  testWidgets('navigates to LoginPage when logout tapped', (tester) async {
    when(() => mockGetProfileUseCase.call())
        .thenAnswer((_) async => Right(testProfile));

    profileBloc.emit(ProfileLoaded(testProfile));
    await tester.pumpWidget(buildTestableWidget());
    await tester.pumpAndSettle();

    final logoutButton = find.widgetWithText(ElevatedButton, 'Logout');
    expect(logoutButton, findsOneWidget);

    await tester.ensureVisible(logoutButton);
    await tester.tap(logoutButton);
    await tester.pumpAndSettle();

    expect(find.byType(LoginPage), findsOneWidget);
  });

  testWidgets('dispatches UpdateProfile event when update tapped', (tester) async {
    when(() => mockGetProfileUseCase.call())
        .thenAnswer((_) async => Right(testProfile));

    when(() => mockUpdateProfileUseCase.call(any(), newPassword: any(named: 'newPassword')))
        .thenAnswer((_) async => Right(testProfile));

    profileBloc.emit(ProfileLoaded(testProfile));
    await tester.pumpWidget(buildTestableWidget());
    await tester.pumpAndSettle();

    final nameField = find.widgetWithText(TextFormField, 'Name');
    expect(nameField, findsOneWidget);

    await tester.enterText(nameField, 'New Name');

    final updateButton = find.widgetWithText(ElevatedButton, 'Update Profile');
    expect(updateButton, findsOneWidget);

    await tester.tap(updateButton);
    await tester.pump();

    verify(() => mockUpdateProfileUseCase.call(any(), newPassword: any(named: 'newPassword'))).called(1);
  });
}
