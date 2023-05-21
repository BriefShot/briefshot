import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';

import 'package:briefshot/services/MapService.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final MapService mapService;
  MapBloc(this.mapService)
      : super(MapState._(
            isLoading: false,
            isGoToDevicePosition: false,
            initialCameraPosition: const CameraPosition(
              target: LatLng(48.856614, 2.3522219),
              zoom: 7,
            ))) {
    on<GoToDevicePosition>((event, emit) async {
      try {
        final response = await mapService.getCurrentPosition();
        await mapService.setPositionOnMap(response);
        emit(MapState.isGoToDevicePosition());
      } catch (e) {
        emit(MapState.isLocationDisabled());
      }
    });

    on<InitMapEvent>((event, emit) async {
      mapService.initializeMap(event.controller);
      emit(MapState.isLoading());
    });
  }

  Stream<MapState> mapEventToState(MapEvent event) async* {}
}
