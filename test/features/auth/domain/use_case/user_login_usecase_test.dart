import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:fashora_app/core/error/failure.dart';
import 'package:fashora_app/features/auth/domain/use_case/user_login_usecase.dart';
import 'package:fashora_app/features/auth/domain/repository/user_repository.dart';
import 'package:fashora_app/app/shared_prefs/token_shared_prefs.dart';

// Mocks for repository and shared prefs
class MockUserRepository extends Mock implements IuserRepository {}

class MockTokenSharedPrefs extends Mock implements TokenSharedPrefs {}

void main() {
  late UserLoginUsecase usecase;
  late MockUserRepository mockUserRepository;
  late MockTokenSharedPrefs mockTokenSharedPrefs;

  const tEmail = 'test@example.com';
  const tPassword = 'password123';
  const tToken = 'mock_token';
  const tParams = LoginUsecaseParams(email: tEmail, password: tPassword);

  setUp(() {
    mockUserRepository = MockUserRepository();
    mockTokenSharedPrefs = MockTokenSharedPrefs();
    usecase = UserLoginUsecase(
      userRepository: mockUserRepository,
      tokenSharedPrefs: mockTokenSharedPrefs,
    );
  });

  test('should return token and save it when login is successful', () async {
    // Arrange: repository returns Right(token)
    when(() => mockUserRepository.loginUser(tEmail, tPassword))
        .thenAnswer((_) async => const Right(tToken));

    // Arrange: shared prefs saveToken returns Future<void>
    when(() => mockTokenSharedPrefs.saveToken(tToken))
        .thenAnswer((_) async => Future.value());

    // Act
    final result = await usecase(tParams);

    // Assert
    expect(result, const Right(tToken));
    verify(() => mockUserRepository.loginUser(tEmail, tPassword)).called(1);
    verify(() => mockTokenSharedPrefs.saveToken(tToken)).called(1);
  });

  test('should return failure when login fails', () async {
    // Arrange: repository returns Left(Failure)
    final failure = RemoteDatabaseFailure(message: 'Invalid credentials');
    when(() => mockUserRepository.loginUser(tEmail, tPassword))
        .thenAnswer((_) async => Left(failure));

    // Act
    final result = await usecase(tParams);

    // Assert
    expect(result, Left(failure));
    verify(() => mockUserRepository.loginUser(tEmail, tPassword)).called(1);
    verifyNever(() => mockTokenSharedPrefs.saveToken(any()));
  });
}
