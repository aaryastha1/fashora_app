import 'package:dartz/dartz.dart';
import 'package:fashora_app/core/error/failure.dart';
import 'package:fashora_app/features/auth/data/data_source/remote_datasource/user_remote_datasource.dart';
import 'package:fashora_app/features/auth/domain/entity/user_entity.dart';
import 'package:fashora_app/features/auth/domain/repository/user_repository.dart';

class UserRemoteRepository  implements IuserRepository{
  final UserRemoteDatasource _userRemoteDataSource;


   UserRemoteRepository({
    required UserRemoteDatasource userRemoteDataSource,
  }) : _userRemoteDataSource = userRemoteDataSource;




  @override
  Future<Either<Failure, String>> loginUser(String email, String password) async {

    try{
      final result = await _userRemoteDataSource.loginUser(email, password);
      return Right(result);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  
   
  }

  @override
  Future<Either<Failure, void>> registerUser(UserEntity user) async {

     try {
      await _userRemoteDataSource.registerUser(user);
      return const Right(null);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
 
  }
}