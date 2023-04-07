part of 'home_bloc.dart';

class HomeState extends Equatable {
  final bool isLoading;
  final bool isGoToDevicePosition;
  CameraPosition? initialCameraPosition;

  HomeState._(
      {required this.isLoading,
      required this.isGoToDevicePosition,
      required this.initialCameraPosition});

  HomeState.isLoading()
      : this._(
            isLoading: true,
            isGoToDevicePosition: false,
            initialCameraPosition: null);

  HomeState.isGoToDevicePosition()
      : this._(
            isLoading: false,
            isGoToDevicePosition: true,
            initialCameraPosition: null);

  @override
  List<Object> get props => [isLoading, isGoToDevicePosition];
}
