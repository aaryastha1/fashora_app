import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fashora_app/app/usecase/use_case.dart';
import 'package:fashora_app/core/error/failure.dart';
import 'package:fashora_app/features/auth/domain/entity/user_entity.dart';
import 'package:fashora_app/features/auth/domain/repository/user_repository.dart';

class RegisterUserParams extends Equatable{
  final String name;
  final String email;
  final String phoneNumber;
  final String password;

  const RegisterUserParams({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.password,
  });

    //intial constructor
    const RegisterUserParams.intial({
      required this.name,
      required this.email,
      required this.phoneNumber,
      required this.password
    });
  
  @override

  List<Object?> get props => [
    name,
    email,
    phoneNumber,
    password
  ];
}

class UserRegisterUsecase  implements UsecaseWithParams<void, RegisterUserParams>{
  final IuserRepository _userRepository;
  UserRegisterUsecase({required IuserRepository userReposiotry})
  : _userRepository = userReposiotry;

  @override
  Future<Either<Failure, void>> call(RegisterUserParams params) {
    final userEntity = UserEntity(
      name: params.name,
      email : params.email,
      phoneNumber: params.phoneNumber,
      password: params.password,

    );
    return _userRepository.registerUser(userEntity);
  
   
  }
}