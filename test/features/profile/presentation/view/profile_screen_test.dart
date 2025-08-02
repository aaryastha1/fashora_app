import 'package:bloc_test/bloc_test.dart';
import 'package:fashora_app/features/auth/presentation/view/login.dart';
import 'package:fashora_app/features/profile/domain/entity/profile_entity.dart';
import 'package:fashora_app/features/profile/presentation/view_model/profile_event.dart';
import 'package:fashora_app/features/profile/presentation/view_model/profile_state.dart';
import 'package:fashora_app/features/profile/presentation/view_model/profile_viewmodel.dart';
import 'package:fashora_app/features/profile/presentation/view/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Mocks and Fakes
class MockProfileBloc extends MockBloc<ProfileEvent, ProfileState>
    implements ProfileBloc {}

class FakeProfileEvent extends Fake implements ProfileEvent {}

class FakeProfileState extends Fake implements ProfileState {}

class FakeProfileEntity extends Fake implements ProfileEntity {}

void main() {
  late MockProfileBloc mockProfileBloc;

  const testProfile = ProfileEntity(
    userId: '123',
    name: 'John Doe',
    email: 'john@example.com',
    phoneNumber: '1234567890',
    profileImageUrl: 'url',
    address: 'Kathmandu',
  );

  setUpAll(() {
    registerFallbackValue(FakeProfileEvent());
    registerFallbackValue(FakeProfileState());
  });

  setUp(() {
    mockProfileBloc = MockProfileBloc();
  });

  Widget buildTestableWidget(Widget child) {
    return MaterialApp(
      home: BlocProvider<ProfileBloc>.value(
        value: mockProfileBloc,
        child: child,
      ),
      routes: {
        '/login': (context) => const LoginPage(),
      },
    );
  }

  testWidgets('shows loading indicator when state is ProfileLoading', (tester) async {
    when(() => mockProfileBloc.state).thenReturn(ProfileLoading());

    await tester.pumpWidget(buildTestableWidget(const ProfileScreen(userId: '123')));
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('shows profile form when state is ProfileLoaded', (tester) async {
    when(() => mockProfileBloc.state).thenReturn(ProfileLoaded(testProfile));

    await tester.pumpWidget(buildTestableWidget(const ProfileScreen(userId: '123')));
    await tester.pumpAndSettle();

    expect(find.text('John Doe'), findsOneWidget);
    expect(find.text('john@example.com'), findsOneWidget);
    expect(find.text('1234567890'), findsOneWidget);
    expect(find.text('Update Profile'), findsOneWidget);
    expect(find.text('Logout'), findsOneWidget);
  });

  testWidgets('dispatches UpdateProfile when update button is tapped', (tester) async {
    when(() => mockProfileBloc.state).thenReturn(ProfileLoaded(testProfile));

    await tester.pumpWidget(buildTestableWidget(const ProfileScreen(userId: '123')));
    await tester.pumpAndSettle();

    // Find the TextFormField by label text
    final nameFieldFinder = find.widgetWithText(TextFormField, 'Name');

    // Enter new text
    await tester.enterText(nameFieldFinder, 'New Name');

    // Tap Update Profile button
    await tester.tap(find.text('Update Profile'));
    await tester.pump();

    // Verify UpdateProfile event dispatched
    verify(() => mockProfileBloc.add(
          any(that: isA<UpdateProfile>()),
        )).called(1);
  });





  testWidgets('shows error SnackBar when state is ProfileError', (tester) async {
    when(() => mockProfileBloc.state).thenReturn(ProfileError('Something went wrong'));

    await tester.pumpWidget(buildTestableWidget(const ProfileScreen(userId: '123')));
    await tester.pump();

    expect(find.text('Something went wrong'), findsOneWidget);
  });
}
