// // part of 'login_cubit.dart';

import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoadingLoginState extends LoginState {}

class SuccessLoginState extends LoginState {
  final String message;

  const SuccessLoginState({required this.message});
  @override
  List<Object> get props => [message];
}

class ErrorLoginState extends LoginState {
  final String message;

  const ErrorLoginState({required this.message});
  @override
  List<Object> get props => [message];
}

class LoadingRegisterState extends LoginState {}

class SuccessRegisterState extends LoginState {
  final String message;

  const SuccessRegisterState({required this.message});
  @override
  List<Object> get props => [message];
}

class ErrorRegisterState extends LoginState {
  final String message;

  const ErrorRegisterState({required this.message});
  @override
  List<Object> get props => [message];
}

// abstract class LoginState {}
// class LoginInitial extends LoginState {}
// class LoadingLoginState extends LoginState {}
// class SuccessLoginState extends LoginState {
//   final String message;
//   SuccessLoginState({required this.message});
// }
// class ErrorLoginState extends LoginState {
//   final String message;
//   ErrorLoginState({required this.message});
// }
