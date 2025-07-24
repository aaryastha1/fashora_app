import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entity/profile_entity.dart';
import '../repository/profile_repository.dart';

class GetProfile {
  final IProfileRepository repository;

  GetProfile(this.repository);

  Future<Either<Failure, ProfileEntity>> call() async {
    return await repository.getProfile();
  }
}
