import 'package:academic_teacher/data/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:academic_teacher/bloc/auth/authentication_event.dart';
import 'package:academic_teacher/bloc/auth/authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  AuthenticationBloc({required this.userRepository})
    : super(AuthenticationInitial()) {
    // Define how each event will be handled
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<AuthenticationCheckRequested>(_onAuthenticationCheckRequested);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoading());

    try {
      final token = await userRepository.login(event.email, event.password);

      emit(Authenticated(token));
    } catch (e) {
      debugPrint("Authentication Failed");
      emit(AuthenticationFailure(e.toString()));
    }
  }

  void _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthenticationState> emit,
  ) {
    emit(Unauthenticated(''));
    userRepository.removeToken();
  }

  Future<void> _onAuthenticationCheckRequested(
    AuthenticationCheckRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoading());
    final token = await userRepository.getToken();
    if (token != null) {
      if (await userRepository.me()) {
        emit(Authenticated(token));
        // emit(AuthenticationSuccess(token));
      } else {
        emit(Unauthenticated(''));
      }
    } else {
      emit(Unauthenticated(''));
    }
  }
}
