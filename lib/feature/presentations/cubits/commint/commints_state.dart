part of 'commints_cubit.dart';

sealed class CommintsState extends Equatable {
  const CommintsState();

  @override
  List<Object> get props => [];
}

final class CommintsInitial extends CommintsState {}

class LoadingCommint extends CommintsState {}

class SuccessCommint extends CommintsState {
  List<CommintModel> commints;
  SuccessCommint({required this.commints});
}

class ErrorCommint extends CommintsState {
  final String message;
  ErrorCommint({required this.message});

  @override
  List<Object> get props => [message];
}
