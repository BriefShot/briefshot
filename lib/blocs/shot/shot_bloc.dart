import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:briefshot/repository/PlaceRepository.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_maps_webservice/places.dart';

part 'shot_event.dart';
part 'shot_state.dart';

class ShotBloc extends Bloc<ShotEvent, ShotState> {
  final PlaceRepository placeRepository = PlaceRepository();
  ShotBloc() : super(ShotInitial()) {
    on<ShotNameChanged>((event, emit) {
      emit(ShotUpdated(
          shotName: event.shotName,
          shotPlace: state.shotPlace,
          shotImage: state.shotImage));
    });
    on<ShotImageChangeAsked>((event, emit) async {
      final ImagePicker _picker = ImagePicker();
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      emit(
        ShotUpdated(
            shotImage: File(image!.path),
            shotName: state.shotName,
            shotPlace: state.shotPlace),
      );
    });
    on<ShotPlaceAsked>((event, emit) {
      emit(ShotUpdated(
          shotPlace: state.shotPlace,
          shotName: state.shotName,
          shotImage: state.shotImage,
          isMapDisplayed: true));
    });
    on<ShotPlaceBackAsked>((event, emit) {
      emit(ShotUpdated(
        shotPlace: state.shotPlace,
        shotName: state.shotName,
        shotImage: state.shotImage,
        isMapDisplayed: false,
      ));
    });
    on<ShotPlaceChangedAsked>((event, emit) {
      emit(ShotUpdated(
        shotPlace: event.location,
        shotName: state.shotName,
        shotImage: state.shotImage,
        isMapDisplayed: true,
      ));
    });
    on<ShotPostAsked>((event, emit) {
      placeRepository.addPlace(
          event.shotName, event.shotImage, event.shotPlace);

      emit(ShotCreated());
    });
  }
}
