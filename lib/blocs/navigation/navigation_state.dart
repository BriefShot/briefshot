part of 'navigation_bloc.dart';

@immutable
class NavigationState {
  final int currentTabIndex;
  final List<Widget> screens;

  const NavigationState({required this.currentTabIndex, required this.screens});
}
