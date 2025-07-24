import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fashora_app/features/profile/domain/usecase/get_profile_usecase.dart';
import 'package:fashora_app/features/profile/domain/usecase/update_profile_usecase.dart';
import 'package:fashora_app/features/profile/presentation/view_model/profile_event.dart';
import 'package:fashora_app/features/profile/presentation/view_model/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfile _getProfileUseCase;
  final UpdateProfileUsecase _updateProfileUseCase;

  ProfileBloc(this._getProfileUseCase, this._updateProfileUseCase) : super(ProfileInitial()) {
    on<LoadProfile>((event, emit) async {
      emit(ProfileLoading());
      final result = await _getProfileUseCase.call();
      result.fold(
        (failure) => emit(ProfileError(failure.message)),
        (profile) => emit(ProfileLoaded(profile)),
      );
    });

    on<UpdateProfile>((event, emit) async {
      emit(ProfileLoading());
      final result = await _updateProfileUseCase.call(event.profile, newPassword: event.newPassword);
      result.fold(
        (failure) => emit(ProfileError(failure.message)),
        (updated) => emit(ProfileUpdated(updated)),
      );
    });
  }
}
