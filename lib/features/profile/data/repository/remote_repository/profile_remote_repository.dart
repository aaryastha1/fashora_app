import 'package:dartz/dartz.dart';
import 'package:fashora_app/core/error/failure.dart';
import 'package:fashora_app/core/error/server_failure.dart';
import 'package:fashora_app/features/profile/data/data_source/profile_datasource.dart';
import 'package:fashora_app/features/profile/domain/entity/profile_entity.dart';
import 'package:fashora_app/features/profile/domain/repository/profile_repository.dart';

class ProfileRemoteRepositoryImpl implements IProfileRepository {
  final IProfileRemoteDataSource remoteDataSource;

  ProfileRemoteRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, ProfileEntity>> getProfile() async {
    try {
      final profile = await remoteDataSource.getProfile();
      return Right(profile);
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to fetch profile'));
    }
  }

  @override
  Future<Either<Failure, ProfileEntity>> updateProfile(ProfileEntity updatedUser, {String? newPassword}) async {
    try {
      final profile = await remoteDataSource.updateProfile(updatedUser, newPassword: newPassword);
      return Right(profile);
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to update profile'));
    }
  }
}
