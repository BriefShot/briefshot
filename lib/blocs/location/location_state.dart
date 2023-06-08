part of 'location_bloc.dart';

abstract class LocationState extends Equatable {
  LocationState();

  List<Prediction> predictions = [];
  Location? location;

  @override
  List<Object> get props => [predictions];
}

class LocationInitial extends LocationState {}

class LocationPredictionsLoaded extends LocationState {
  LocationPredictionsLoaded({required this.predictions});

  @override
  final List<Prediction> predictions;

  @override
  List<Object> get props => [predictions];
}

class LocationSelected extends LocationState {
  LocationSelected({required this.location});

  @override
  final Location location;

  @override
  List<Object> get props => [location];
}
