import 'package:arta_app/feature/data/models/ads/ads_model.dart';
import 'package:equatable/equatable.dart';

abstract class ListingState extends Equatable {
  const ListingState();

  @override
  List<Object> get props => [];
}

class ListingInitial extends ListingState {}

class LoadingListingState extends ListingState {}

class SuccessListingState extends ListingState {
  final List<ListingModel> listing;

  const SuccessListingState({required this.listing});
  @override
  List<Object> get props => [listing];
}

class ErrorListingState extends ListingState {
  final String message;

  const ErrorListingState({required this.message});
  @override
  List<Object> get props => [message];
}

class LoadingSingleListingState extends ListingState {}

class SuccessSingleListingState extends ListingState {
  final ListingModel listing;

  const SuccessSingleListingState({required this.listing});
  @override
  List<Object> get props => [listing];
}

class ErrorListingSingleState extends ListingState {
  final String message;

  const ErrorListingSingleState({required this.message});
  @override
  List<Object> get props => [message];
}

class AddingListingLoadingState extends ListingState {}

class AddedListingSuccessState extends ListingState {}

class ErrorAddingListingState extends ListingState {
  final String message;

  const ErrorAddingListingState({required this.message});
  @override
  List<Object> get props => [message];
}
