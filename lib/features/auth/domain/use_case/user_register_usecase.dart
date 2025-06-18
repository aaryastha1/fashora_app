import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fashora_app/app/usecase/use_case.dart';
import 'package:fashora_app/core/error/failure.dart';
import 'package:fashora_app/features/auth/domain/entity/user_entity.dart';
import 'package:fashora_app/features/auth/domain/repository/user_repository.dart';

class RegisterUseParams extends Equatable{
  final String fullName;
  final String email;
  final String phonenumber;
  final String password;

  const RegisterUseParams({
    required this.fullName,
    required this.email,
    required this.phonenumber,
    required this.password,
  });

    //intial constructor
    const RegisterUseParams.intial({
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

class UserRegisterUsecase  implements UsecaseWithParams<void, RegisterUseParams>{
  final IuserRepository _userRepository;
  UserRegisterUsecase({required IuserRepository userReposiotry})
  : _userRepository = userReposiotry;

  @override
  Future<Either<Failure, void>> call(RegisterUseParams params) {
    final userEntity = UserEntity(
      fullName: params.fullName,
      email : params.email,
      phonenumber: params.phonenumber,
      password: params.password,

    );
    return _userRepository.registerUser(userEntity);
  
   
  }
}