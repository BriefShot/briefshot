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
  final Location location;

  const ShotPlaceChangedAsked({required this.location});

  @override
  List<Object> get props => [location];
}

class ShotPlaceBackAsked extends ShotEvent {}

class ShotPlaceSelected extends ShotEvent {
  final Location location;

  const ShotPlaceSelected({required this.location});

  @override
  List<Object> get props => [location];
}

class ShotPostAsked extends ShotEvent {
  final String shotName;
  final String shotImage;
  final Location shotPlace;

  const ShotPostAsked({
    required this.shotName,
    required this.shotImage,
    required this.shotPlace,
  });

  @override
  List<Object> get props => [shotName, shotImage, shotPlace];
}
