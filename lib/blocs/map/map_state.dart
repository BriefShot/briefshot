part of 'map_bloc.dart';

class MapState extends Equatable {
  final bool isLoading;
  final bool isGoToDevicePosition;
  final bool isLocationDisabled;
  DateTime? requestedAt;
  CameraPosition? initialCameraPosition;

  MapState._(
      {required this.isLoading,
      required this.isGoToDevicePosition,
      required this.initialCameraPosition,
      this.isLocationDisabled = false,
      this.requestedAt});

  MapState.isLoading()
      : this._(
            isLoading: true,
            isGoToDevicePosition: false,
            initialCameraPosition: null);

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
