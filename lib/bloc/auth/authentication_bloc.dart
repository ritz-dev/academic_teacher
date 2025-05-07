import 'package:academic_teacher/data/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:academic_teacher/bloc/auth/authentication_event.dart';
import 'package:academic_teacher/bloc/auth/authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent,AuthenticationState>{
    final UserRepository userRepository;
     
    AuthenticationBloc({required this.userRepository}) : super(AuthenticationInitial()) {
    // Define how each event will be handled
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }


  Future<void> _onLoginRequested(LoginRequested event,Emitter<AuthenticationState> emit) async{
     emit(AuthenticationLoading());

     try {
      final token = await userRepository.login(event.email, event.password);
      
      emit(AuthenticationSuccess(token));
    } catch (e) {
      debugPrint("Authentication Failed");
      emit(AuthenticationFailure(e.toString()));
    }
  }

  void _onLogoutRequested(LogoutRequested event,Emitter<AuthenticationState> emit){
    emit(Unauthenticated(''));
    userRepository.removeToken();
  }
}
