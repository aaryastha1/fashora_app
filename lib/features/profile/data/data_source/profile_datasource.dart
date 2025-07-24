import 'package:fashora_app/features/profile/domain/entity/profile_entity.dart';

abstract class IProfileRemoteDataSource {
  Future<ProfileEntity> getProfile();

  /// Update profile with optional password change
  Future<ProfileEntity> updateProfile(ProfileEntity profile, {String? newPassword});
}
