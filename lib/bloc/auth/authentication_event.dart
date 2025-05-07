import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginRequested extends AuthenticationEvent {
  final String email;
  final String password;

  LoginRequested(this.email, this.password);

  @override
  List<Object> get props => [];
}

class AuthenticationCheckRequested extends AuthenticationEvent {
  AuthenticationCheckRequested();
  @override
  List<Object> get props => [];
}

class LogoutRequested extends AuthenticationEvent {}
