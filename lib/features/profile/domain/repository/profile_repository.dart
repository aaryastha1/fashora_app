import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entity/profile_entity.dart';

abstract class IProfileRepository {
  Future<Either<Failure, ProfileEntity>> getProfile();
  Future<Either<Failure, ProfileEntity>> updateProfile(ProfileEntity updatedUser, {String? newPassword});
}
