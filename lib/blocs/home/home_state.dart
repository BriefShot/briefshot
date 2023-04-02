part of 'home_bloc.dart';

class HomeState extends Equatable {
  final bool isLoading;
  final bool isGoToDevicePosition;

  const HomeState._(
      {required this.isLoading, required this.isGoToDevicePosition});

  const HomeState.isLoading()
      : this._(isLoading: true, isGoToDevicePosition: false);

  const HomeState.isGoToDevicePosition()
      : this._(isLoading: false, isGoToDevicePosition: true);

  @override
  List<Object> get props => [isLoading, isGoToDevicePosition];
}
