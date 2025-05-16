import 'package:equatable/equatable.dart';

import '../../../data/models/regetion/get_pernte.dart';

// abstract class RegetionState extends Equatable {
//   @override
//   List<Object> get props => [];
// }

// class RegetionInitial extends RegetionState {}

// //---------------Regetion Parent -------------------

// class LoadingRegetionParentState extends RegetionState {}

// class SuccessRegetionParentState extends RegetionState {
//   final List<RegetionParent> cities;
//   SuccessRegetionParentState({this.cities = const []});

//   @override
//   List<Object> get props => [cities];
// }

// class ErrorRegetionParentState extends RegetionState {
//   final String message;
//   ErrorRegetionParentState({required this.message});

//   @override
//   List<Object> get props => [message];
// }

// //------------------Regetion Child (Cities)------------------
// class LoadingRegetionChildState extends RegetionState {}

// class SuccessRegetionChildState extends RegetionState {
//   final List<RegetionParent> regetions;
//   SuccessRegetionChildState({this.regetions = const []});

//   @override
//   List<Object> get props => [regetions];
// }

// class ErrorRegetionChildState extends RegetionState {
//   final String message;
//   ErrorRegetionChildState({required this.message});

//   @override
//   List<Object> get props => [message];
// }

abstract class RegetionState {}

class RegetionInitial extends RegetionState {}

// حالات تحميل وتحديد المدن
class LoadingRegetionParentState extends RegetionState {}
class SuccessRegetionParentState extends RegetionState {
  final List<RegetionParent> cities;
  SuccessRegetionParentState({required this.cities});
}
class ErrorRegetionParentState extends RegetionState {
  final String message;
  ErrorRegetionParentState({required this.message});
}

// حالة تحديد مدينة
class CitySelectedState extends RegetionState {
  final List<RegetionParent> cities;
  final RegetionParent? selectedCity;
  final List<RegetionParent> regions;
  
  CitySelectedState({
    required this.cities,
    required this.selectedCity,
    required this.regions,
  });
}

// حالات تحميل وتحديد المناطق
class LoadingRegetionChildState extends RegetionState {
  final List<RegetionParent> cities;
  final RegetionParent? selectedCity;
  
  LoadingRegetionChildState({
    required this.cities,
    required this.selectedCity,
  });
}

class SuccessRegetionChildState extends RegetionState {
  final List<RegetionParent> cities;
  final RegetionParent? selectedCity;
  final List<RegetionParent> regions;
  
  SuccessRegetionChildState({
    required this.cities,
    required this.selectedCity,
    required this.regions,
  });
}

class ErrorRegetionChildState extends RegetionState {
  final String message;
  final List<RegetionParent> cities;
  final RegetionParent? selectedCity;
  
  ErrorRegetionChildState({
    required this.message,
    required this.cities,
    required this.selectedCity,
  });
}

// حالة تحديد منطقة
class RegionSelectedState extends RegetionState {
  final List<RegetionParent> cities;
  final RegetionParent? selectedCity;
  final List<RegetionParent> regions;
  final RegetionParent? selectedRegion;
  
  RegionSelectedState({
    required this.cities,
    required this.selectedCity,
    required this.regions,
    required this.selectedRegion,
  });
}
