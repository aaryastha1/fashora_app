import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fashora_app/features/auth/domain/entity/user_entity.dart';
import 'package:fashora_app/features/auth/domain/use_case/user_register_usecase.dart';
import 'package:fashora_app/core/error/failure.dart';
import 'package:fashora_app/features/auth/domain/repository/user_repository.dart';

// Mock class
class MockUserRepository extends Mock implements IuserRepository {}

void main() {
  late MockUserRepository repository;
  late UserRegisterUsecase usecase;

  setUp(() {
    repository = MockUserRepository();
    usecase = UserRegisterUsecase(userReposiotry: repository);

    // Register fallback for UserEntity used internally in the use case
    registerFallbackValue(UserEntity.empty());
  });

  final params = const RegisterUserParams(
    name: 'Test User',
    email: 'test@email.com',
    phoneNumber: '1234567890',
    password: 'securepassword',
  );

  final expectedUserEntity = UserEntity(
    name: params.name,
    email: params.email,
    phoneNumber: params.phoneNumber,
    password: params.password,
  );

  test('should call registerUser and return Right(null)', () async {
    // Arrange
    when(() => repository.registerUser(any()))
        .thenAnswer((_) async => const Right(null));

    // Act
    final result = await usecase(params);

    // Assert
    expect(result, const Right<Failure, void>(null));
    verify(() => repository.registerUser(expectedUserEntity)).called(1);
  });
}
