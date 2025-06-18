import 'package:dartz/dartz.dart';
import 'package:fashora_app/core/error/failure.dart';
import 'package:fashora_app/features/auth/domain/entity/user_entity.dart';

abstract interface class IuserRepository{
  Future <Either<Failure, void>> registerUser(UserEntity user);

  Future<Either<Failure, String >> loginUser( String email, String password);
}