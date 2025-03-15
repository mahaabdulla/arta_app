import 'package:arta_app/feature/data/models/category.dart';
import 'package:equatable/equatable.dart';

abstract class CategoryState extends Equatable {
  @override
  List<Object> get props => [];
}

class CategoryInitial extends CategoryState {}

class LoadingCategoryState extends CategoryState {}

class SuccessCategoryState extends CategoryState {
  final List<Category> categories;
  SuccessCategoryState({this.categories = const []});
  
  @override
  List<Object> get props => [categories];
}

class ErrorCategoryState extends CategoryState {
  final String message;
  ErrorCategoryState({required this.message});
  
  @override
  List<Object> get props => [message];
}
