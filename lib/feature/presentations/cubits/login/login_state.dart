
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
}

class ErrorLoginState extends LoginState {
  final String message;

  const ErrorLoginState({required this.message});
}

