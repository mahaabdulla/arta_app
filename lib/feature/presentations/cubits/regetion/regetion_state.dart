import 'package:equatable/equatable.dart';

import '../../../data/models/regetion/get_pernte.dart';

abstract class RegetionState extends Equatable {
  @override
  List<Object> get props => [];
}

class RegetionInitial extends RegetionState {}

//---------------Regetion Parent -------------------

class LoadingRegetionParentState extends RegetionState {}

class SuccessRegetionParentState extends RegetionState {
  final List<RegetionParent> cities;
  SuccessRegetionParentState({this.cities = const []});

  @override
  List<Object> get props => [cities];
}

class ErrorRegetionParentState extends RegetionState {
  final String message;
  ErrorRegetionParentState({required this.message});

  @override
  List<Object> get props => [message];
}

//------------------Regetion Child (Cities)------------------
class LoadingRegetionChildState extends RegetionState {}

class SuccessRegetionChildState extends RegetionState {
  final List<RegetionParent> regetions;
  SuccessRegetionChildState({this.regetions = const []});

  @override
  List<Object> get props => [regetions];
}

class ErrorRegetionChildState extends RegetionState {
  final String message;
  ErrorRegetionChildState({required this.message});

  @override
  List<Object> get props => [message];
}
