import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entity/profile_entity.dart';
import '../repository/profile_repository.dart';

class UpdateProfileUsecase {
  final IProfileRepository repository;

  UpdateProfileUsecase(this.repository);

  Future<Either<Failure, ProfileEntity>> call(
    ProfileEntity profile, {
    String? newPassword,
  }) async {
    return await repository.updateProfile(profile, newPassword: newPassword);
  }
}
