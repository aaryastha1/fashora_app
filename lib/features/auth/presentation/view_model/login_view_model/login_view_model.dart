


import 'package:fashora_app/app/service_locator/service_locator.dart';
import 'package:fashora_app/core/common/snackbar/my_snackbar.dart';
import 'package:fashora_app/features/auth/domain/use_case/user_login_usecase.dart';
import 'package:fashora_app/features/auth/presentation/view/dashboard_screen.dart';
import 'package:fashora_app/features/auth/presentation/view/sign_up.dart';
import 'package:fashora_app/features/auth/presentation/view_model/login_view_model/login_event.dart';
import 'package:fashora_app/features/auth/presentation/view_model/login_view_model/login_state.dart';
import 'package:fashora_app/features/auth/presentation/view_model/register_view_model/register_view_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginViewModel extends Bloc<LoginEvent, LoginState> {
  final UserLoginUsecase _userLoginUsecase;

  LoginViewModel(this._userLoginUsecase) : super(LoginState.initial()) {
    on<NavigateToRegisterViewEvent>(_onNavigateToRegisterView);
    on<LoginWithEmailAndPasswordEvent>(_onLoginWithEmailAndPassword);
  }

  void _onNavigateToRegisterView(
    NavigateToRegisterViewEvent event,
    Emitter<LoginState> emit,
  ) {
    if (event.context.mounted) {
      Navigator.push(
        event.context,
        MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: serviceLocator<RegisterViewModel>()),
            ],
            child: const RegisterView(),
          ),
        ),
      );
    }
  }

  void _onLoginWithEmailAndPassword(
    LoginWithEmailAndPasswordEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await _userLoginUsecase(
      LoginUsecaseParams(email: event.email, password: event.password),
    );

    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, isSuccess: false));
        showMySnackBar(
          context: event.context,
          message: 'Invalid credentials. Please try again.',
          color: Colors.red,
        );
      },
      (token) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
        showMySnackBar(
          context: event.context,
          message: "Login Successful",
          color: Colors.green,
        );

        // ✅ Navigate to DashboardScreen
        Navigator.pushReplacement(
          event.context,
          MaterialPageRoute(
            builder: (_) =>  DashboardScreen(),
          ),
        );
      },
    );
  }
}