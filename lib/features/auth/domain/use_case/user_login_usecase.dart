import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fashora_app/app/usecase/use_case.dart';
import 'package:fashora_app/core/error/failure.dart';
import 'package:fashora_app/features/auth/domain/repository/user_repository.dart';

class LoginUsecaseParams extends Equatable{
  final String email;
  final String password;

  const LoginUsecaseParams({required this.email, required this.password});

  const LoginUsecaseParams.initial() : email = '', password = '';


  @override
 
  List<Object?> get props => [email, password];

}

class UserLoginUsecase implements UsecaseWithParams<String, LoginUsecaseParams> {
  final IuserRepository _userRepository;

  UserLoginUsecase({required IuserRepository userRepository})
    : _userRepository = userRepository;

  @override
  Future<Either<Failure, String>> call(LoginUsecaseParams params) {
    
    return _userRepository.loginUser(params.email, params.password);
  }
}