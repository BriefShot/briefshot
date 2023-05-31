part of 'shot_bloc.dart';

abstract class ShotEvent extends Equatable {
  const ShotEvent();

  @override
  List<Object?> get props => [];
}

class AddShotAsked extends ShotEvent {}

class ShotNameChanged extends ShotEvent {
  final String shotName;

  const ShotNameChanged({required this.shotName});

  @override
  List<Object> get props => [shotName];
}

class ShotImageChangeAsked extends ShotEvent {}

class ShotPlaceAsked extends ShotEvent {}

class ShotPlaceChangedAsked extends ShotEvent {
  final Marker marker;

  const ShotPlaceChangedAsked({required this.marker});

  @override
  List<Object> get props => [marker];
}

class ShotPlaceBackAsked extends ShotEvent {}
