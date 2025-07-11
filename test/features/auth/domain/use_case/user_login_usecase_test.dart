// import 'package:dartz/dartz.dart';
// import 'package:fashora_app/features/auth/domain/entity/user_entity.dart';
// import 'package:fashora_app/features/auth/domain/use_case/user_login_usecase.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'repository.mock.dart';

// void main() {
//   late MockUserRepository repository;
//   late UserLoginUsecase usecase;

//   setUp(() {
//     repository = MockUserRepository();
//     usecase = UserLoginUsecase(userRepository: repository);
//     registerFallbackValue(UserEntity.empty());
//   });

//   final params = LoginUsecaseParams.initial();

//   test('should call loginUser and return Right(null)', () async {
//     // Arrange
   
//     when(() => repository.loginUser(any())).thenAnswer((_) async => Right(null));

//     // Act
//     final result = await usecase(params);

//     // Assert
//     expect(result, Right(null));
//     verify(() => repository.loginUser(any())).called(1);
//   });

// }


import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fashora_app/features/auth/domain/use_case/user_login_usecase.dart';
import 'package:fashora_app/core/error/failure.dart';
import 'package:fashora_app/features/auth/domain/repository/user_repository.dart';


class MockUserRepository extends Mock implements IuserRepository {}

void main() {
  late MockUserRepository repository;
  late UserLoginUsecase usecase;

  setUp(() {
    repository = MockUserRepository();
    usecase = UserLoginUsecase(userRepository: repository);
  });

  const params = LoginUsecaseParams(email: "test@email.com", password: "123456");

  test('should call loginUser and return Right with token string', () async {
    // Arrange
    const expectedToken = "fake_token_123";
    when(() => repository.loginUser(params.email, params.password))
        .thenAnswer((_) async => const Right(expectedToken));

    // Act
    final result = await usecase(params);

    // Assert
    expect(result, const Right<Failure, String>(expectedToken));
    verify(() => repository.loginUser(params.email, params.password)).called(1);
  });
}

