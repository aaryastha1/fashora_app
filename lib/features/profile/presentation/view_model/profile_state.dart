import 'package:equatable/equatable.dart';
import 'package:fashora_app/features/profile/domain/entity/profile_entity.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final ProfileEntity profile;

  const ProfileLoaded(this.profile);

  @override
  List<Object?> get props => [profile];
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);

  @override
  List<Object?> get props => [message];
}

class ProfileUpdated extends ProfileState {
  final ProfileEntity updatedProfile;

  const ProfileUpdated(this.updatedProfile);

  @override
  List<Object?> get props => [updatedProfile];
}
