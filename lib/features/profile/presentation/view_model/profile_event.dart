import 'package:equatable/equatable.dart';
import 'package:fashora_app/features/profile/domain/entity/profile_entity.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class LoadProfile extends ProfileEvent {}

class UpdateProfile extends ProfileEvent {
  final ProfileEntity profile;
  final String? newPassword;

  const UpdateProfile(this.profile, {this.newPassword});

  @override
  List<Object?> get props => [profile, newPassword];
}
