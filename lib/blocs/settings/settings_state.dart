part of 'settings_bloc.dart';

class SettingsState extends Equatable {
  final String appBarTitle;
  final Widget? widget;
  const SettingsState(this.appBarTitle, this.widget);

  const SettingsState.initialState(
      {required this.appBarTitle, required this.widget});

  const SettingsState.email({required this.appBarTitle, required this.widget});

  const SettingsState.password(
      {required this.appBarTitle, required this.widget});

  const SettingsState.subscription(
      {required this.appBarTitle, required this.widget});

  const SettingsState.notifications(
      {required this.appBarTitle, required this.widget});

  const SettingsState.logout({required this.appBarTitle, required this.widget});

  @override
  List<Object?> get props => [appBarTitle, widget];
}
