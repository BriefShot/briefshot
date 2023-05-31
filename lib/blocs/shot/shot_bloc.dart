import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

part 'shot_event.dart';
part 'shot_state.dart';

class ShotBloc extends Bloc<ShotEvent, ShotState> {
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
      print(image!.path);
      emit(
        ShotUpdated(
            shotImage: File(image.path),
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
      print("object");
      emit(ShotUpdated(
          shotPlace: state.shotPlace,
          shotName: state.shotName,
          shotImage: state.shotImage,
          isMapDisplayed: false));
    });
  }
}
