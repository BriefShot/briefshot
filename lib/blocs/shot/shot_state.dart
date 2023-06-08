part of 'shot_bloc.dart';

class ShotState extends Equatable {
  String? shotName;
  File? shotImage;
  Location? shotPlace;
  bool isMapDisplayed = false;
  ShotState();

  @override
  List<Object?> get props => [];
}

class ShotInitial extends ShotState {}

class ShotUpdated extends ShotState {
  String? shotName;
  File? shotImage;
  Location? shotPlace;
  bool isMapDisplayed;

  ShotUpdated(
      {this.shotName,
      this.shotImage,
      this.shotPlace,
      this.isMapDisplayed = false});

  @override
  List<Object?> get props => [shotName, shotImage, shotPlace, isMapDisplayed];
}

class ShotCreated extends ShotState {
  String? shotName;
  File? shotImage;
  Location? shotPlace;
  bool isMapDisplayed = true;

  ShotCreated({
    this.shotName,
    this.shotImage,
    this.shotPlace,
  });

  @override
  List<Object?> get props => [shotName, shotImage, shotPlace];
}
