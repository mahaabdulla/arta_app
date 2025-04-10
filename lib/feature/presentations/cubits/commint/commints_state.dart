part of 'commints_cubit.dart';

sealed class CommintsState extends Equatable {
  const CommintsState();

  @override
  List<Object> get props => [];
}

final class CommintsInitial extends CommintsState {}

class LoadingCommintState extends CommintsState {}

class SuccessCommintState extends CommintsState {
  final CommintModel commint;

  const SuccessCommintState({required this.commint});

  @override
  List<Object> get props => [commint];
}

class ErrorCommintState extends CommintsState {
  final String message;
  ErrorCommintState({required this.message});

  @override
  List<Object> get props => [message];
}
