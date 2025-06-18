import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fashora_app/app/usecase/use_case.dart';
import 'package:fashora_app/core/error/failure.dart';
import 'package:fashora_app/features/auth/domain/entity/user_entity.dart';
import 'package:fashora_app/features/auth/domain/repository/user_repository.dart';

class RegisterUserParams extends Equatable{
  final String fullName;
  final String email;
  final String phonenumber;
  final String password;

  const RegisterUserParams({
    required this.fullName,
    required this.email,
    required this.phonenumber,
    required this.password,
  });

    //intial constructor
    const RegisterUserParams.intial({
      required this.fullName,
      required this.email,
      required this.phonenumber,
      required this.password
    });
  
  @override

  List<Object?> get props => [
    fullName,
    email,
    phonenumber,
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
      fullName: params.fullName,
      email : params.email,
      phonenumber: params.phonenumber,
      password: params.password,

    );
    return _userRepository.registerUser(userEntity);
  
   
  }
}