import 'package:arta_app/feature/data/models/ads/ads_model.dart';
import 'package:equatable/equatable.dart';

sealed class RegionState extends Equatable {
  const RegionState();

  @override
  List<Object> get props => [];
}

final class RegionInitial extends RegionState {}

final class ParentRegionsLoading extends RegionState {}

final class ParentRegionsLoaded extends RegionState {
  final List<RegionModel> regions;

  const ParentRegionsLoaded(this.regions);

  @override
  List<Object> get props => [regions];
}

final class ParentRegionsError extends RegionState {
  final String message;

  const ParentRegionsError(this.message);

  @override
  List<Object> get props => [message];
}

final class ChildRegionsLoading extends RegionState {}

final class ChildRegionsLoaded extends RegionState {
  final List<RegionModel> childRegions;

  const ChildRegionsLoaded(this.childRegions);

  @override
  List<Object> get props => [childRegions];
}

final class ChildRegionsError extends RegionState {
  final String message;

  const ChildRegionsError(this.message);

  @override
  List<Object> get props => [message];
}
