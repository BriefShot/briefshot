part of 'map_bloc.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();
  @override
  List<Object> get props => [];
}

class InitMapEvent extends MapEvent {
  const InitMapEvent(this.controller);

  final GoogleMapController controller;
  @override
  List<Object> get props => [];
}

class SetMapController extends MapEvent {
  const SetMapController();
}

class GoToDevicePosition extends MapEvent {
  // final _requestedAt = DateTime.now();

  GoToDevicePosition();

  @override
  List<Object> get props => [];
}
