import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];

  String? get token => null;
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class Unauthenticated extends AuthenticationState {
  @override
  final String token;
  Unauthenticated(this.token);

  @override
  List<Object> get props => [token];
}

// class AuthenticationSuccess extends AuthenticationState {
//   @override
//   final String token;
//   // AuthenticationSuccess(this.token);

//   AuthenticationSuccess(this.token) {
//     debugPrint('Success is $token');
//   }

//   @override
//   List<Object> get props => [token];
// }

class Authenticated extends AuthenticationState {
  @override
  final String token;
  Authenticated(this.token);

  @override
  List<Object> get props => [token];
}

class AuthenticationFailure extends AuthenticationState {
  final String error;
  AuthenticationFailure(this.error);

  @override
  List<Object> get props => [error];
}
