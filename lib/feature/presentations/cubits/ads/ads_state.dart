import 'package:arta_app/feature/data/models/ads/ads_model.dart';
import 'package:equatable/equatable.dart';

abstract class AdsState extends Equatable {
  const AdsState();

  @override
  List<Object> get props => [];
}

class AdsInitial extends AdsState {}

class LoadingAdsState extends AdsState {}

class SuccessAdsState extends AdsState {
  final AdsModel ads;

  const SuccessAdsState({required this.ads});
  @override
  List<Object> get props => [ads];
}

class ErrorAdsState extends AdsState {
  final String message;

  const ErrorAdsState({required this.message});
  @override
  List<Object> get props => [message];
}
