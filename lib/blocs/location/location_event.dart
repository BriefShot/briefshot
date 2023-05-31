part of 'location_bloc.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class LocationSearch extends LocationEvent {
  LocationSearch({required this.input});

  final String input;

  @override
  List<Object> get props => [input];
}

class LocationPredictionSelected extends LocationEvent {
  LocationPredictionSelected({required this.prediction});

  final Prediction prediction;

  @override
  List<Object> get props => [prediction];
}
