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

class GoToDevicePosition extends HomeEvent {}
