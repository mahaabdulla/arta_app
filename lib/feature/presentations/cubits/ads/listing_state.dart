import 'package:arta_app/feature/data/models/ads/ads_model.dart';

abstract class ListingState {}

class ListingInitial extends ListingState {}

class LoadingListingState extends ListingState {}

class SuccessListingState extends ListingState {
  final List<ListingModel> listing;
  final List<ListingModel>? filteredListing;

  SuccessListingState({required this.listing, this.filteredListing});
}

class ErrorListingState extends ListingState {
  final String message;

  ErrorListingState({required this.message});
}

class LoadingSingleListingState extends ListingState {}

class SuccessSingleListingState extends ListingState {
  final ListingModel listing;

  SuccessSingleListingState({required this.listing});
}

class ErrorListingSingleState extends ListingState {
  final String message;

  ErrorListingSingleState({required this.message});
}
