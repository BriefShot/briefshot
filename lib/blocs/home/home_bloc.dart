import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:briefshot/services/MapService.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc()
      : super(HomeState._(
            isLoading: false,
            isGoToDevicePosition: false,
            initialCameraPosition: const CameraPosition(
              target: LatLng(48.856614, 2.3522219),
              zoom: 7,
            ))) {
    // Controller de GMaps, TODO Valentin : j'étudie plus tard parce que apparemment y'a mieux mais pour l'instant ça marche
    dynamic controller;

    // Obtenir la position de l'utilisateur (avec vérifs d'autorisation pour iOS)
    // Modifier la caméra de Maps sur cette position
    on<GoToDevicePosition>((event, emit) async {
      emit(HomeState.isGoToDevicePosition());
      final response = await MapService().getCurrentPosition();
      await MapService().setPositionOnMap(controller, response);
    });

    // Google Maps a besoin d'un controleur, ça lui permet d'intéragir avec la map
    // Donc dans le onMapCreated, on appelle SetMapController pour toujours l'avoir sous la main
    on<SetMapController>((event, emit) {
      controller = event.controller;
    });

    on<SetMapStyle>((event, emit) {
      MapService().setMapStyle(controller, event.mapStyle);
    });
  }

  // static CameraPosition get initialCameraPosition => _kGooglePlex;

  // Completer<GoogleMapController> get controller => _controller;

  // final Completer<GoogleMapController> _controller =
  //     Completer<GoogleMapController>();

  // static const CameraPosition _kGooglePlex = CameraPosition(
  //   target: LatLng(37.42796133580664, -122.085749655962),
  //   zoom: 14.4746,
  // );

  // static const CameraPosition _kLake = CameraPosition(
  //     bearing: 192.8334901395799,
  //     target: LatLng(37.43296265331129, -122.08832357078792),
  //     tilt: 59.440717697143555,
  //     zoom: 19.151926040649414);

  // Future<void> _goToTheLake() async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  // }

  // static const CameraPosition _devicePosition = CameraPosition(
  //     bearing: 192.8334901395799,
  //     target: LatLng(1.43296265331129, 12.08832357078792),
  //     tilt: 59.440717697143555,
  //     zoom: 19.151926040649414);

  // Future<void> _goToDevicePosition() async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(_devicePosition));
  // }

  Stream<HomeState> mapEventToState(HomeEvent event) async* {}
}
