part of 'map_bloc.dart';

class MapState extends Equatable {
  final bool isLoading;
  final bool isGoToDevicePosition;
  final bool isLocationDisabled;
  List<Marker> markers = [];
  DateTime? requestedAt;
  CameraPosition? initialCameraPosition;

  MapState._({
    required this.isLoading,
    required this.isGoToDevicePosition,
    required this.initialCameraPosition,
    this.isLocationDisabled = false,
    this.requestedAt,
    this.markers = const [
      Marker(
          markerId: MarkerId("value1"),
          position: LatLng(3908.856614, 20.3522219)),
      Marker(
          markerId: MarkerId("value2"),
          position: LatLng(128.856614, 2.3522219)),
      Marker(
          markerId: MarkerId("value3"),
          position: LatLng(100.856614, 2.3522219)),
    ],
  });

  MapState.isLoading()
      : this._(
          isLoading: true,
          isGoToDevicePosition: false,
          initialCameraPosition: null,
        );

  MapState.isGoToDevicePosition()
      : this._(
            isLoading: false,
            isGoToDevicePosition: true,
            initialCameraPosition: null);

  MapState.isLocationDisabled()
      : this._(
            isLoading: false,
            isGoToDevicePosition: false,
            isLocationDisabled: true,
            initialCameraPosition: null,
            requestedAt: DateTime.now());

  @override
  List<Object?> get props => [isLoading, isGoToDevicePosition, requestedAt];
}
