import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fashora_app/app/shared_prefs/token_shared_prefs.dart';
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
  final TokenSharedPrefs _tokenSharedPrefs;

  UserLoginUsecase({required IuserRepository userRepository,required TokenSharedPrefs tokenSharedPrefs})
    : _userRepository = userRepository, _tokenSharedPrefs = tokenSharedPrefs;

  @override
  Future<Either<Failure, String>> call(LoginUsecaseParams params) async{
    // return _userRepository.loginUser(params.email, params.password);
    final result = await _userRepository.loginUser(
      params.email,
      params.password,
    );

    return result.fold((failure) => Left(failure), (token) async {
      await _tokenSharedPrefs.saveToken(token);
      return Right(token);
    });
  }
}

