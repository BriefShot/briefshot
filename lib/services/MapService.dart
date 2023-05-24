import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapService {
  dynamic controller;
  String mapStyle = '';
  MapService(BuildContext context) {
    _loadMapStyle(context);
  }

  Future<void> _loadMapStyle(BuildContext context) async {
    final string = await DefaultAssetBundle.of(context)
        .loadString('assets/json/mapStyle.json');
    mapStyle = string;
  }

  Future<Position> getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    try {
      final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      return position;
    } catch (e) {
      return Future.error('Failed to get current position.');
    }
  }

  Future<void> setPositionOnMap(Position position) async {
    final CameraPosition cameraPosition = CameraPosition(
      target: LatLng(position.latitude, position.longitude),
      zoom: 8,
    );
    await controller
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  initializeMap(GoogleMapController controller) {
    this.controller = controller;
    this.controller.setMapStyle(mapStyle);
  }
}
