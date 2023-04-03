part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class SetMapController extends HomeEvent {
  final GoogleMapController controller;

  const SetMapController(this.controller);
}

class SetMapStyle extends HomeEvent {
  final String mapStyle;

  const SetMapStyle(this.mapStyle);
}

class GoToDevicePosition extends HomeEvent {}
